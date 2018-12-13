//
//  Environment.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation
import UIKit

struct Environment {
    static let BASE_URL : String = "https://parseapi.back4app.com/"
}

struct Constants {
    
    // search
    static let TITLE_HEADER_GAME = ["New","Popular","All", "Filtered Result"]
    
    
    static let INTER_SPACING : CGFloat = 14.0
    static let EXTRA_ITEM_SPACE : CGFloat = 14.0
    static let HEIGHT_COMPONENT : CGFloat =  220
    static let ITEM_SIZE : CGSize = CGSize(width: (UIScreen.main.bounds.width - (EXTRA_ITEM_SPACE * 2))/3, height: HEIGHT_COMPONENT)
    static let FILTER_ITEM_SIZE : CGSize = CGSize(width: (UIScreen.main.bounds.width  - 30) / 2, height: (UIScreen.main.bounds.width - 30) / 2)
    static let FILTER_HEADER_OPTIONS = ["Sorting by","Price","Sorting by"]
    static let FILTER_FIRST_OPTION = ["Popularity","New","Price"]
    static let FILTER_BRAND_OPTION = ["Nintendo","PlayStation","XBox"]
}


enum BrandGame : String {
    case nintendo = "Nintendo"
    case playStation = "PlayStation"
    case pc = "PC"
    case xBox = "Xbox"
}
