//
//  characterCell.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/3/24.
//

import UIKit

class characterCell: UITableViewCell {
    @IBOutlet weak var characterID: UILabel!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    var tapAction : ((UITableViewCell) -> Void)?
    @IBAction func wikiBtnAction(_ sender: Any) {
        tapAction?(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
