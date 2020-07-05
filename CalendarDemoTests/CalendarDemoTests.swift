//
//  CalendarDemoTests.swift
//  CalendarDemoTests
//
//  Created by tùng hoàng on 7/4/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import XCTest
@testable import CalendarDemo
class CalendarDemoTests: XCTestCase {
  
  
  func testResponse() throws {
    let service = Service(url: "https://demo2187508.mockable.io/")
    var resultDays: [Day]?
    let dataExpectation = expectation(description: "data")
    service.request(path: "workouts") { result in
      dataExpectation.fulfill()
      switch result {
      case .success(let data):
        resultDays = data
      case .failure(_):
        break
      }
    }
    XCTAssertEqual(service.url, "https://demo2187508.mockable.io/", "url is right")
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(resultDays)
    }
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
}
