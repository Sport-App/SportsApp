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
    
    func build(type : ViewType , appDelegate : AppDelegate) -> DataSourceDelegate {
        switch type {
        case .fav:
            return OfflineService(appDelegate: appDelegate)
        default:
            return NetworkService()
        }
    }
}
