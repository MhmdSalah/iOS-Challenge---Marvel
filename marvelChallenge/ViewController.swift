//
//  ViewController.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    var resultsJSON:[JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        self.performURLRequest()
        
    }
    
    func createGetRequest() {
        let ts = Date().timeIntervalSince1970
        print(ts)
    }
    
    func performURLRequest(offset:Int = 0) {
        let t = MBProgressHUD.showAdded(to: self.view, animated: true)
        t.label.text = "Loading Data"
        t.contentColor = .darkText
        
        let ts = Date().timeIntervalSince1970
        let hash = "\(ts)\(constatnsForAPI.privateKey)\(constatnsForAPI.publicKey)".md5
        
        var comp = URLComponents(string: "\(constatnsForAPI.baseURL)\(constatnsForAPI.charactersPath)")
        
        var queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "apikey", value: constatnsForAPI.publicKey),
                    URLQueryItem(name: "ts", value: "\(ts)"),
                    URLQueryItem(name: "hash", value: hash)
        ]
        
        comp?.queryItems = queryItems
        
        let requestURL = comp!.url!
        
        print("url is going to be : ", requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let responseData = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    DispatchQueue.main.async {
                        self.showNetworkError(errorDesc: error?.localizedDescription)
                    }
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    DispatchQueue.main.async {
                        self.showNetworkError(errorDesc: error?.localizedDescription)
                    }
                }
                return
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                let jsn = JSON(responseData)
                if let dataArray = jsn["data"]["results"].array {
                    self.resultsJSON += dataArray
                }
                self.mainTable.reloadData()

            }
        }
        
        task.resume()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultsJSON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! characterCell
        let data = self.resultsJSON[indexPath.row]
        cell.characterID.text = data["id"].stringValue
        cell.characterName.text = data["name"].stringValue
        let imgurl = data["thumbnail"]["path"].stringValue + "." + data["thumbnail"]["extension"].stringValue
        cell.characterImage.imageFromServerURL(urlString: imgurl, PlaceHolderImage: UIImage(named: "placeholder")!)
        cell.tapAction = { cel in
            print("did select wiki \(indexPath.row)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

