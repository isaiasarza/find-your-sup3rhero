//
//  EventListViewController.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 11/09/2022.
//

import UIKit
import FirebaseAuth
class EventListViewController: UIViewController {
    
    @IBOutlet weak var eventsTableView: UITableView!
    private var events: [Event] = []
    private var isLoading = false
    private let userDefaults = UserDefaults.standard
    private var imagesDictionary: [Int: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSignOutButton()
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "loadingcellid")
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "eventsTableViewCell")
        if Auth.auth().currentUser != nil {
            self.getEvents()
        }
    }
    
    private func getEvents(){
        isLoading = true
        let limit = 25
        let orderBy = "startDate"
        let urlString: String = MarvelApiManager.getEventsUrl(limit: limit, orderBy: orderBy)
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        Task {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            do{
                let eventDataWrapper: EventsDataWrapper = try JSONDecoder().decode(EventsDataWrapper.self, from: data)
                let events: [Event] = try eventDataWrapper.data!.results!
                self.events.append(contentsOf: events)
                self.isLoading = false
                eventsTableView.reloadData()
                async let downloading = downloadImagesTaskGroup(events: events)
            }catch{
                print("fetch characters error!")
            }
        }
    }
    
    private func downloadImagesTaskGroup(events: [Event]) async {
        let dictionary = await withTaskGroup(of: (Int, UIImage).self,
                                             returning: [Int: UIImage].self,
                                             body: { taskGroup in
            for event in events {
                taskGroup.addTask {
                    let imageURL: String = "\(event.thumbnail!.path!).\(event.thumbnail!.extension!)"
                    let image = await ImageUtils.fetchImage(URLAddress: imageURL) as! UIImage?
                    return (event.id!, image!)
                }
            }
            var childTaskResults = [Int: UIImage]()
            for await result in taskGroup {
                childTaskResults[result.0] = result.1
            }
            return childTaskResults
        })
        for (key, value) in dictionary {
            self.imagesDictionary[key] = value
        }
        eventsTableView.reloadData()
    }
}

extension EventListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return events.count
        }else if isLoading {
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = eventsTableView.dequeueReusableCell(withIdentifier: "eventsTableViewCell", for: indexPath) as! EventTableViewCell
            let currentEvent = events[indexPath.row]
            cell.eventName.text = currentEvent.title!
            if let image = imagesDictionary[currentEvent.id!] {
                cell.eventThumbnail.image = image
            }else{
                // default image
                cell.eventThumbnail.image = ImageUtils.resizeImage(image: UIImage(named: "downloading")!, targetSize: CGSize(width: 120, height: 120))
            }
            return cell
        }else {
            let cell = eventsTableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 128
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        let selectedEvent = events[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        vc.event = selectedEvent
        if let image = imagesDictionary[selectedEvent.id!]{
            vc.image = image
        }else{
            vc.image = ImageUtils.resizeImage(image: UIImage(named: "downloading")!, targetSize: CGSize(width: 120, height: 120))
        }
        self.present(vc, animated: true)
    }
}

extension EventListViewController: SignOutButtonProtocol{
    var buttonTitle: String {
        get {
            "Salir"
        }
    }
    
    @objc func onClickMessageButton() {
        Task{
            do{
                try await Auth.auth().signOut()
            }catch let error{
                print("signOut error: \(error)")
            }
            userDefaults.set(false, forKey: ConfigVariables.loggedInKey)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
