//
//  LeaguesViewModelTest.swift
//  SportsAppTests
//
//  Created by ahmed on 5/6/21.
//

import XCTest
@testable import SportsApp

class LeaguesViewModelTest: XCTestCase {

    var leaguesDetailsViewModel : LeaguesViewModel?
    var leaguesFavViewModel : LeaguesViewModel?

    var expecttionObj:XCTestExpectation?

    override func setUpWithError() throws {
        leaguesDetailsViewModel = LeaguesViewModel(sportsName: "soccer", type: .details, appDelegate: UIApplication.shared.delegate as! AppDelegate)
        leaguesFavViewModel = LeaguesViewModel(sportsName: "soccer", type: .details, appDelegate: UIApplication.shared.delegate as! AppDelegate)

        leaguesDetailsViewModel?.bindLeaguestoView = didReceiveData
        leaguesDetailsViewModel?.bindErrortoView = didReceiveError
        expecttionObj = expectation(description: "Wait for response")
    }

    override func tearDownWithError() throws {
        leaguesDetailsViewModel = nil
        expecttionObj = nil
    }
    func didReceiveData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.expecttionObj?.fulfill()
            XCTAssertGreaterThanOrEqual(self.leaguesDetailsViewModel!.Leagues.count, 1)

        })
    }
    
    func didReceiveError() {
        XCTFail()
        expecttionObj?.fulfill()

    }
    func testGetOnlineLeagues() throws {
        leaguesDetailsViewModel?.getLeagues()
        waitForExpectations(timeout: 5)
    }
    func testGetOfflineLeagues() throws {
        
        leaguesFavViewModel?.getLeagues()
        waitForExpectations(timeout: 5)

    }

}
