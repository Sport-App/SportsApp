//
//  TeamViewModel.swift
//  SportsApp
//
//  Created by ahmed on 4/28/21.
//

import Foundation
class TeamViewModel {
    let networkServic = NetworkService()
    
    var team: Team! {
        didSet{
            bindTeamtoView()
        }
    }
    
    var error: String! {
        didSet{
            bindErrortoView()
        }
    }
    
    var bindTeamtoView: () -> () = {}
    var bindErrortoView: () -> () = {}
    
    func getTeam(id:String) {
        networkServic.getTeamById( id: id, completion: { (team, error) in
            
            if let error = error {
                self.error = error.localizedDescription
            }else{
                self.team = team
            }
        })
    }
}
