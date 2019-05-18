//
//  TheMovieDatabaseTests.swift
//  TheMovieDatabaseTests
//
//  Created by Marcelo José on 08/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import XCTest
@testable import TheMovieDatabase

class TheMovieDatabaseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListModel() {
        let model = ListModel()
        var listData: [ListModelData]!

        let expectation = self.expectation(description: "Scaling")

        model.getMovieList(nextPage: false, scope: 0, responseHandler: { (result) in
            listData = result
            expectation.fulfill()
        }) { (error) in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(listData != nil)
    }

    func testPerformanceExample() {
        self.measure {
        }
    }
}
