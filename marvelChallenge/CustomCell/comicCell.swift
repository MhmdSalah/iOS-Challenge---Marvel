//
//  comicCell.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/4/24.
//

import UIKit

class comicCell: UITableViewCell {
    
    
    @IBOutlet weak var comicIDlabel: UILabel!
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(data:JSON) {
        self.comicIDlabel.text = data["id"].stringValue
        self.comicNameLabel.text = data["title"].stringValue
        let imgurl = data["thumbnail"]["path"].stringValue + "." + data["thumbnail"]["extension"].stringValue
        self.comicImageView.imageFromServerURL(urlString: imgurl, PlaceHolderImage: UIImage(named: "placeholder")!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
