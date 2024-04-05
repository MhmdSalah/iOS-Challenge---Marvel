//
//  Services.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/5/24.
//

import Foundation

struct webServices {
    static func performCharactersRequest(offset:Int = 0, sourceView:characterViewController) {
        let t = MBProgressHUD.showAdded(to: sourceView.view, animated: true)
        t.label.text = offset == 0 ? "Loading Characters" : "Loading 20 more"
        t.contentColor = .darkText
        
        let ts = Date().timeIntervalSince1970
        let hash = "\(ts)\(constatnsForAPI.privateKey)\(constatnsForAPI.publicKey)".md5
        
        var comp = URLComponents(string: "\(constatnsForAPI.baseURL)\(constatnsForAPI.charactersPath)")
        
        let queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "apikey", value: constatnsForAPI.publicKey),
                    URLQueryItem(name: "ts", value: "\(ts)"),
                    URLQueryItem(name: "hash", value: hash),
                    URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        comp?.queryItems = queryItems
        
        let requestURL = comp!.url!
        
        print("url is going to be : ", requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            sourceView.currentlyLoadingData = false
            guard let responseData = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: sourceView.view, animated: true)
                    DispatchQueue.main.async {
                        sourceView.showNetworkError(errorDesc: error?.localizedDescription)
                    }
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: sourceView.view, animated: true)
                    DispatchQueue.main.async {
                        sourceView.showNetworkError(errorDesc: error?.localizedDescription)
                    }
                }
                return
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: sourceView.view, animated: true)
                let jsn = JSON(responseData)
                if let dataArray = jsn["data"]["results"].array {
                    sourceView.resultsJSON += dataArray
                }
                sourceView.mainTable.reloadData()
                sourceView.pagingVariable += 20
            }
        }
        sourceView.currentlyLoadingData = true
        task.resume()
    }
    
    static func loadComicsData(offset:Int = 0, sourceView:detailsViewController) {
        let t = MBProgressHUD.showAdded(to: sourceView.view, animated: true)
        t.label.text = offset == 0 ? "Loading Comics" : "Loading 20 more"
        t.contentColor = .darkText
        
        let ts = Date().timeIntervalSince1970
        let hash = "\(ts)\(constatnsForAPI.privateKey)\(constatnsForAPI.publicKey)".md5
        
        var comp = URLComponents(string: "\(constatnsForAPI.baseURL)\(constatnsForAPI.charactersPath)/\(sourceView.currentCharacterID)\(constatnsForAPI.comicsPath)")
        
        let queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "apikey", value: constatnsForAPI.publicKey),
                    URLQueryItem(name: "ts", value: "\(ts)"),
                    URLQueryItem(name: "hash", value: hash),
                    URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        comp?.queryItems = queryItems
        
        let requestURL = comp!.url!
        
        print("url is going to be : ", requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            sourceView.currentlyLoadingData = false
            guard let responseData = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: sourceView.view, animated: true)
                    DispatchQueue.main.async {
                        sourceView.showNetworkError(errorDesc: error?.localizedDescription)
                    }
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: sourceView.view, animated: true)
                    DispatchQueue.main.async {
                        sourceView.showNetworkError(errorDesc: error?.localizedDescription)
                    }
                }
                return
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: sourceView.view, animated: true)
                let jsn = JSON(responseData)
                if let dataArray = jsn["data"]["results"].array {
                    sourceView.comicsJSON += dataArray
                }
                sourceView.comicsTable.reloadData()
                sourceView.pagingVariable += 20
            }
        }
        sourceView.currentlyLoadingData = true
        task.resume()
    }

}
