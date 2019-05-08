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

    func testMovieService() {
        let service = MovieService()
        var movideData: MovieResult!

        let expectation = self.expectation(description: "Scaling")

        service.fetchUpcommingService(page: 1, responseHandler: { (data) in
            movideData = data
            expectation.fulfill()
        }) { (_) in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(movideData != nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
