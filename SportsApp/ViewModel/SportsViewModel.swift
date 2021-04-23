//
//  SportsViewModel.swift
//  SportsApp
//
//  Created by Abanob Wadie on 23/04/2021.
//

import Foundation

class SportsViewModel {
    let networkServic = NetworkService()
    
    var sports: [Sport]! {
        didSet{
            bindSportstoView()
        }
    }
    
    var error: String! {
        didSet{
            bindErrortoView()
        }
    }
    
    var bindSportstoView: () -> () = {}
    var bindErrortoView: () -> () = {}
    
    func getSports() {
        networkServic.getSports { (sport, error) in
            
            if let error = error {
                self.error = error.localizedDescription
            }else{
                self.sports = sport
            }
        }
    }
}
