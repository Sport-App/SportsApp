//
//  OfflineService.swift
//  SportsApp
//
//  Created by ahmed on 4/25/21.
//

import Foundation
import CoreData

class OfflineService : DataSourceDelegate {
    var leagueName = String()
    var leagueId = String()
    var sportsName = String()
    var managedContext :NSManagedObjectContext
    var entity : NSEntityDescription
    var fetchRequest : NSFetchRequest<NSFetchRequestResult>
    
    init(appDelegate: AppDelegate) {
        self.managedContext = appDelegate.persistentContainer.viewContext
        self.entity = NSEntityDescription.entity(forEntityName: "FavLeagues", in: managedContext)!
        self.fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeagues")

    }
    
    
    func getLeagues(completion: @escaping ([LeagueDetails]?, Error?) -> ()) {
        var list:[LeagueDetails] = []
        do {
            let leagues = try self.managedContext.fetch(fetchRequest) as! [FavLeagues]
            for league in leagues{
                let leagueDetails = LeagueDetails()
                leagueDetails.strLeague = league.name
                leagueDetails.strBadge = league.image
                leagueDetails.strYoutube = league.youtube
                list.append(leagueDetails)
            }
            completion(list,nil)
        } catch let error as NSError {
            completion(nil,error)
        }

    }
    func delete(name : String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeagues")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let leagues = try managedContext.fetch(fetchRequest) as! [FavLeagues]
            managedContext.delete(leagues[0])
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    func add(league:LeagueDetails){
        let leagueEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        leagueEntity.setValue(league.strLeague, forKey: "name")
        leagueEntity.setValue(league.strYoutube, forKey: "youtube")
        leagueEntity.setValue(league.strBadge, forKey: "image")
        leagueEntity.setValue("", forKey: "id")
        do {
            try self.managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }

   }
    
}
