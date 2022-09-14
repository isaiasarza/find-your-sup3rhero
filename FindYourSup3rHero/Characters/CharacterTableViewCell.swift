//
//  CharacterTableViewCell.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 09/09/2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    var imageURL: String?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        name.textColor = .darkGray
        characterDescription.numberOfLines = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
