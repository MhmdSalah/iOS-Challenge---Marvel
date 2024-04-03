//
//  Character.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/3/24.
//

import Foundation

struct Character {
    let id: Int?
    let name: String?
    let wikiURL: String?
    let imageURL: String?
    
    let comicsJSON:JSON?
    
    init(id: Int? = nil,
         name: String? = nil,
         wikiURL: String? = nil,
         imageURL: String? = nil,
         comicsJSON: JSON? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.wikiURL = wikiURL
        self.comicsJSON = comicsJSON
    }
}
