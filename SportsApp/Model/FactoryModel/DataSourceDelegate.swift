//
//  DataSourceDelegate.swift
//  SportsApp
//
//  Created by Abanob Wadie on 23/04/2021.
//

import Foundation

protocol DataSourceDelegate {
    var sportsName: String { get set }
    
    func getLeagues(completion: @escaping ([LeagueDetails]?, Error?) -> ())
}
