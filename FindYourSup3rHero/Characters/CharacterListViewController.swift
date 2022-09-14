//
//  CharacterListViewController.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 08/09/2022.
//

import UIKit
import Foundation
import FirebaseAuth
class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    private var characters: [Character] = []
    private var images: [UIImage] = []
    private var isLoading = false
    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        addSignOutButton()
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "loadingcellid")
        charactersTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterTableViewCell")
        charactersTableView.delegate = self
        if Auth.auth().currentUser != nil {
            self.getCharacters()
        }
    }
    
    func loadMoreData(){
        if !self.isLoading {
            self.isLoading = true
            getCharacters()
        }
    }
    
    func getCharacters(){
        let limit = 15
        let offset = self.characters.count
        let urlString: String = MarvelApiManager.getCharactersUrl(limit: limit, offset: offset)
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        Task {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            do{
                let characterDataWrapper: CharacterDataWrapper = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                let characters: [Character] = try characterDataWrapper.data!.results!
                //TODO: descargar las imágenes de forma asincrónica, la implementación actual es bloqueante.
                try await downloadImages(characters: characters)
                self.characters.append(contentsOf: characters)
                self.isLoading = false
                charactersTableView.reloadData()
            }catch{
                print("fetch characters error!")
            }
        }
    }
    
    private func downloadImages(characters: [Character]) async {
        for character in characters {
            let imageURL: String = "\(character.thumbnail!.path!).\(character.thumbnail!.extension!)"
            let image = try await ImageUtils.fetchImage(URLAddress: imageURL) as! UIImage?
            self.images.append(image!)
        }
    }
    
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return characters.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if indexPath.row == self.characters.count - 1, !isLoading {
                self.loadMoreData()
            }
            let cell = charactersTableView.dequeueReusableCell(withIdentifier: "characterTableViewCell", for: indexPath) as! CharacterTableViewCell
            cell.name.text = characters[indexPath.row].name
            cell.characterDescription.text = characters[indexPath.row].description
            
            cell.thumbnail.image = images[indexPath.row]
            return cell
        }else{
            let cell = charactersTableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingTableViewCell
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
        let selectedCharacter = characters[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        vc.character = selectedCharacter
        vc.image = images[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CharacterListViewController: SignOutButtonProtocol{
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

enum UserValidationError: String, Error {
    case noFirstNameProvided = "Please insert your first name."
    
}
