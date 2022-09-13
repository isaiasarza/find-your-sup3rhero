//
//  CharacterDetailViewController.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 09/09/2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var comicsTableView: UITableView!
    var character: Character?
    var comics: [Summary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDescription!.text = character?.description!
        characterDescription!.numberOfLines = 0
        comics.append(contentsOf: character?.comics!.items! ?? [])
        comicsTableView.dataSource = self
        comicsTableView.register(UINib(nibName: "ComicTableViewCell", bundle: nil), forCellReuseIdentifier: "comicTableViewCell")
        self.navigationItem.title = character?.name!
    }

}

extension CharacterDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comics.count == 0{
            var emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "Este personaje no aparece en ningún comic."
            emptyLabel.textAlignment = NSTextAlignment.center
                self.comicsTableView.backgroundView = emptyLabel
            self.comicsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return 0
        } else {
            self.comicsTableView.backgroundView = nil
            return comics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = comicsTableView.dequeueReusableCell(withIdentifier: "comicTableViewCell", for: indexPath) as! ComicTableViewCell
        cell.comicName.text = comics[indexPath.row].name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comics donde aparece"
    }
    
    
}
