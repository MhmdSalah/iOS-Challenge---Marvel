//
//  detailsViewController.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/3/24.
//

import UIKit

class detailsViewController: UIViewController {
    
    var characterData:JSON?

    @IBOutlet weak var comicsTable: UITableView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = characterData {
            self.characterName.text = data["name"].stringValue
            let imgurl = data["thumbnail"]["path"].stringValue + "." + data["thumbnail"]["extension"].stringValue
            self.characterImage.imageFromServerURL(urlString: imgurl, PlaceHolderImage: UIImage(named: "placeholder")!)
            print(data)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension detailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = characterData {
            return 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
