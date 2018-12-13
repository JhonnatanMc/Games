//
//  Game.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation

extension Game: Decodable {
    enum GameKeys: String, CodingKey {
        case gameId     = "objectId"
        case name       = "name"
        case createdAt  = "createdAt"
        case updatedAt  = "updatedAt"
        case brand      = "brand"
        case price      = "price"
        case imageURL   = "imageURL"
        case gender     = "genre"
        case popular    = "popular"
        case rating     = "rating"
        case downloads  = "downloads"
        case sku        =  "SKU"
        case description    = "description"
        
    }
}

struct Game {
    
    var gameId      : String
    var name        : String
    var createdAt   : Date
    var updatedAt   : String
    var brand       : String
    var price       : Double
    var imageURL    : String
    var gender      : String
    var popular     : Bool
    var rating      : String
    var downloads   : String
    var sku         : String
    var description : String
    
    init() {
        self.gameId         = ""
        self.name           = ""
        self.createdAt      = Date()
        self.updatedAt      = ""
        self.brand          = ""
        self.price          = 0.0
        self.imageURL       = ""
        self.gender         = ""
        self.popular        = false
        self.rating         = ""
        self.downloads      = ""
        self.sku            = ""
        self.description    = ""
        
    }
    
    init(from decoder: Decoder) {
        self.init()
        do {
            let container = try decoder.container(keyedBy: GameKeys.self)
            
            self.gameId     =  try container.decode(String.self, forKey: .gameId)
            self.name       =  try container.decode(String.self, forKey: .name)
            
            self.updatedAt  =  try container.decode(String.self, forKey: .updatedAt)
           
            if let myDate = try container.decodeIfPresent(String.self, forKey: .createdAt) {
                self.createdAt = DateUtils.parseStringToDate(myDate)!
            }
            
            self.brand  =  try container.decode(String.self, forKey: .brand)
            
            if let price = try container.decodeIfPresent(String.self, forKey: .price) {
                let priceStr = price.replacingOccurrences(of: ",", with: ".")
                self.price =  (NumberFormatter().number(from: priceStr)?.doubleValue)!
            }
            self.imageURL  =  try container.decode(String.self, forKey: .imageURL)
            self.popular  =  try container.decode(Bool.self, forKey: .popular)
            self.rating  =  try container.decode(String.self, forKey: .rating)
            self.sku  =  try container.decode(String.self, forKey: .sku)
            self.downloads  =  try container.decode(String.self, forKey: .downloads)
            self.description  =  try container.decode(String.self, forKey: .description)
            self.gender =  try container.decode(String.self, forKey: .gender)
            
            
        } catch let error {
            print("error parsing game \(error)")
        }
        
    }
    
}
