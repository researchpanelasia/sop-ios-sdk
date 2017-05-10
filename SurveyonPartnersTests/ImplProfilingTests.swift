//
//  ImplProfilingTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class ImplProfilingTests: XCTestCase {

  func testInit() throws {
    let jsonString = "{\n" +
    "   \"name\": \"q001\",\n" +
    "   \"title\": \"请问您的生日是多少?\",\n" +
    "   \"url\": \"https://partners.surveyon.com/resource/auth/v1_1\"\n" +
    "}"

    let json = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]

    let profiling = try ImplProfiling(json: json)

    XCTAssertEqual(profiling.name, "q001")
    XCTAssertEqual(profiling.title, "请问您的生日是多少?")
    XCTAssertEqual(profiling.url, "https://partners.surveyon.com/resource/auth/v1_1")
  }
}
