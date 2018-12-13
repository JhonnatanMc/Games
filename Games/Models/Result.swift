//
//  Result.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation


extension  Result: Decodable {
    enum ResultKeys: String, CodingKey {
        case game = "results"
    }
}

struct Result {
    
    var game  : [Game]
    
    init() {
        self.game = [Game]()
    }
    
    init(from decoder: Decoder) {
        self.init()
        do {
            let container = try decoder.container(keyedBy:  ResultKeys.self)
            self.game     =  try container.decode([Game].self, forKey: .game)
        } catch let error {
            print("error parse result game \(error)")
        }
    }
    
}
