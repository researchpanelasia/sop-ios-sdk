//
//  PreferencesManagerTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class PreferencesManagerTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testCreateSignatureString() {
    let key = "hoge"
    PreferencesManager.writePreferences(value: 1234567890, forKey: key)
    XCTAssert(PreferencesManager.readIntPreferences(forKey: key) == 1234567890)
  }
}
