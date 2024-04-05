//
//  characterCell.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/3/24.
//

import UIKit
import SafariServices

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
    
    func bindData(data:JSON, viewController:characterViewController) {
        self.characterID.text = data["id"].stringValue
        self.characterName.text = data["name"].stringValue
        let imgurl = data["thumbnail"]["path"].stringValue + "." + data["thumbnail"]["extension"].stringValue
        self.characterImage.imageFromServerURL(urlString: imgurl, PlaceHolderImage: UIImage(named: "placeholder")!)
        self.tapAction = { cel in
            self.cellWikiBtnAction(data: data, viewController: viewController)
        }
    }
    
    func cellWikiBtnAction(data:JSON, viewController:characterViewController) {
        let urls = data["urls"].arrayValue
        let wikidata = urls.filter { (jsn) -> Bool in
            return jsn["type"].stringValue == "wiki"
        }
        if wikidata.isEmpty {
            viewController.showNetworkError(errorDesc: "Wiki url does not exist for this character")
        } else {
            if let url = URL(string: wikidata.first!["url"].stringValue) {
                let safariVC = SFSafariViewController(url: url)
                viewController.present(safariVC, animated: true)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
