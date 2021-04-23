//
//  Sport.swift
//  SportsApp
//
//  Created by ahmed on 4/21/21.
//

import Foundation

class Sports: Codable {
    
    var sports : [Sport]
        
    enum CodingKeys : String , CodingKey {
        case sports = "sports"
    }
    
}

class Sport: Codable {
        
    var id : String
    var name : String
    var type : String
    var image : String
    var description : String
    
    enum CodingKeys : String , CodingKey {
        case id = "idSport"
        case name = "strSport"
        case image = "strSportThumb"
        case description = "strSportDescription"
        case type = "strFormat"

    }
}
