//
//  UtilityTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class UtilityTests: XCTestCase {

  func testGetUserAgent() {
    let userAgent = Utility.getUserAgent()
    let re = try? NSRegularExpression(pattern: "sop-ios-sdk\\d+?[.]\\d+?[.]\\d+? \\(.+?\\)")
    let number = re?.numberOfMatches(in: userAgent, range: NSMakeRange(0, userAgent.characters.count))
    XCTAssertEqual(number, 1)
  }
}
