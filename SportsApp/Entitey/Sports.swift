//
//  Sports.swift
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
