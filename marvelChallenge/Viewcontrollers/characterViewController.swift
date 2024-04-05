//
//  ViewController.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/1/24.
//

import UIKit
import SafariServices

class characterViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    var resultsJSON:[JSON] = []
    var selectedCharacterIndex = 0
    var pagingVariable = 0
    
    ///this boolean variable is true when data is loading so we don't make duplicate data requests
    var currentlyLoadingData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webServices.performCharactersRequest(offset: 0, sourceView: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func createGetRequest() {
        let ts = Date().timeIntervalSince1970
        print(ts)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacter" {
            let detailVC = segue.destination as! detailsViewController
            detailVC.characterData = self.resultsJSON[selectedCharacterIndex]
        }
    }

}

extension characterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultsJSON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! characterCell
        cell.bindData(data: self.resultsJSON[indexPath.row], viewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedCharacterIndex = indexPath.row
        self.performSegue(withIdentifier: "showCharacter", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.resultsJSON.count-1 {
            if !currentlyLoadingData {
                webServices.performCharactersRequest(offset: pagingVariable, sourceView: self)
            }
        }
    }
    
}

