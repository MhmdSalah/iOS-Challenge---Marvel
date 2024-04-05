//
//  detailsViewController.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/3/24.
//

import UIKit

class detailsViewController: UIViewController {
    
    var characterData:JSON?
    
    var comicsJSON:[JSON] = []
    var currentlyLoadingData = false
    var currentCharacterID = 0
    var pagingVariable = 0

    @IBOutlet weak var comicsTable: UITableView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindCharacterData()
        webServices.loadComicsData(offset: 0, sourceView: self)
    }
    
    func bindCharacterData() {
        if let data = characterData {
            self.characterName.text = data["name"].stringValue
            let imgurl = data["thumbnail"]["path"].stringValue + "." + data["thumbnail"]["extension"].stringValue
            self.characterImage.imageFromServerURL(urlString: imgurl, PlaceHolderImage: UIImage(named: "placeholder")!)
            self.currentCharacterID = data["id"].intValue
        }
    }

}

extension detailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsJSON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicCell", for: indexPath) as! comicCell
        cell.bindData(data: comicsJSON[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
