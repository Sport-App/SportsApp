//
//  FactoryService.swift
//  SportsApp
//
//  Created by Abanob Wadie on 23/04/2021.
//

import Foundation

enum ViewType {
    case fav
    case details
}

class FactoryService {
    
    func build() -> DataSourceDelegate {
        return NetworkService()
    }
}
