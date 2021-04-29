//
//  SportsViewModelTest.swift
//  SportsAppTests
//
//  Created by ahmed on 4/29/21.
//

import XCTest
@testable import SportsApp

class SportsViewModelTest: XCTestCase {
    var sportsViewModel : SportsViewModel!
    var expecttionObj:XCTestExpectation!

    override func setUpWithError() throws {
    sportsViewModel = SportsViewModel()
        sportsViewModel.bindSportstoView = didReceiveData
        sportsViewModel.bindErrortoView = didReceiveError
    expecttionObj = expectation(description: "Wait for response")
    }

    override func tearDownWithError() throws {
        sportsViewModel = nil
        expecttionObj = nil
    }
    func didReceiveData() {
        expecttionObj.fulfill()
        XCTAssertEqual(sportsViewModel.sports.count, 20)
    }
    
    func didReceiveError() {
        XCTFail()
        print(sportsViewModel.error!)
    }
    func testGetSports() throws {
        sportsViewModel.getSports()
        waitForExpectations(timeout: 5)

    }

   
}
