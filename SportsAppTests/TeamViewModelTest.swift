//
//  TeamViewModel.swift
//  SportsAppTests
//
//  Created by ahmed on 4/29/21.
//

import XCTest
@testable import SportsApp

class TeamViewModelTest: XCTestCase {
    var teamViewModel : TeamViewModel!
    var expecttionObj:XCTestExpectation!

    override func setUpWithError() throws {
    teamViewModel = TeamViewModel()
    teamViewModel.bindTeamtoView = didReceiveData
    teamViewModel.bindErrortoView = didReceiveError
    expecttionObj = expectation(description: "Wait for response")
    }

    override func tearDownWithError() throws {
        teamViewModel = nil
        expecttionObj = nil
    }
    func didReceiveData() {
        expecttionObj.fulfill()
        
        XCTAssertNotNil(teamViewModel.team)
    }
    
    func didReceiveError() {
        XCTFail()
        print(teamViewModel.error!)
    }
    func testGetSports() throws {
        teamViewModel.getTeam(id: "133604")
        waitForExpectations(timeout: 5)

    }
}
