//
//  CoreDataTest.swift
//  SportsAppTests
//
//  Created by ahmed on 5/4/21.
//

import XCTest
import UIKit
@testable import SportsApp

class CoreDataTest: XCTestCase {
    var offlineService:OfflineService?
    
    override func setUpWithError() throws {
        offlineService = OfflineService(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    }

    override func tearDownWithError() throws {
        offlineService = nil
    }

    func testRead() throws {
        offlineService?.getLeagues(completion: getLeague(ell:ee:))
    }
    
    func getLeague(ell : [LeagueDetails]? , ee : Error?){
        XCTAssertEqual(ell?.count, 8)
    }
    
    func testAdd() throws {
        let leage = LeagueDetails(id: "1", youtube: "youtube", badge: "badge", league: "league")
        leage.strBadge = "1"
        leage.strLeague = "football"
        leage.strYoutube = "youtube"
        offlineService?.add(league: leage)
      
    }
    
    func testDelete() throws {
        offlineService?.delete(name: "football")
    }
    
}
