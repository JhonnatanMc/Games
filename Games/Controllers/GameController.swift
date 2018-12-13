//
//  GameController.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation

class GameController {
    
    /// do a request for get all game and pase the information
    ///
    /// - Parameter callback: information
    class func getGames(_ callback: @escaping (Array<Game>, Bool, String, Int)->Void) -> Void {
        HTTPService.get("classes/Product") { (JSON: Data?, status : Int) in
            do {
                if status == 200 {
                    let games = try JSONDecoder().decode(Result.self, from: JSON!)
                    callback(games.game, false, "", status)
                } else if status == 0 {
                    callback(Array<Game>(), true, "Unable to reach Server. Please check Internet connectivity and try again later.", status)
                } else {
                    callback(Array<Game>(), true, "Couldn't retrieve your information at this moment.", status)
                }
            } catch {
                callback(Array<Game>(), true, "Unable to reach server. Please check Internet connectivity and try again later.", status)
            }
        }
    }
    
}
