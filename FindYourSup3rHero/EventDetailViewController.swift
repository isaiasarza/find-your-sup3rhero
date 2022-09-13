//
//  EventDetailViewController.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 12/09/2022.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var comicsToDiscussTableView: UITableView!
    
    var event: Event?
    var comicsToDiscuss: [Summary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventName!.text = event?.title!
        eventDescription!.text = event?.description!
        eventDescription!.numberOfLines = 0
        comicsToDiscuss.append(contentsOf: event!.comics!.items!)
        comicsToDiscussTableView.dataSource = self
        comicsToDiscussTableView.register(UINib(nibName: "ComicTableViewCell", bundle: nil), forCellReuseIdentifier: "comicTableViewCell")
    }

}

extension EventDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comicsToDiscuss.count == 0{
            var emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "En este evento no se discutirán comics."
            emptyLabel.textAlignment = NSTextAlignment.center
                self.comicsToDiscussTableView.backgroundView = emptyLabel
            self.comicsToDiscussTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return 0
        } else {
            self.comicsToDiscussTableView.backgroundView = nil
            return comicsToDiscuss.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = comicsToDiscussTableView.dequeueReusableCell(withIdentifier: "comicTableViewCell", for: indexPath) as! ComicTableViewCell
        cell.comicName.text = comicsToDiscuss[indexPath.row].name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comics a discutir"
    }
    
    
}
