//
//  AuthenticationTests.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/07.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class AuthenticationTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testCreateSignatureString() {
    let obj = Authentication()
    XCTAssert(obj.createSignature(message: "aaa=aaa&bbb=bbb&ccc=ccc", key: "hogehoge") == "2fbfe87e54cc53036463633ef29beeaa4d740e435af586798917826d9e525112")
  }
  
  func testCreateSignatureDictionary1() {
    let obj = Authentication()
    let populationDict: Dictionary<String,String>  = [
      "ccc": "ccc",
      "aaa": "aaa",
      "bbb": "bbb",
      ]
    
    XCTAssert(obj.createSignature(parameters: populationDict, key: "hogehoge") == "2fbfe87e54cc53036463633ef29beeaa4d740e435af586798917826d9e525112")
  }
  
  func testCreateSignatureDictionary2() {
    let obj = Authentication()
    let populationDict: Dictionary<String,String>  = [
      "ccc": "ccc",
      "aaa": "aaa",
      "bbb": "bbb",
      "sop_hoge": "hoge"
    ]
    
    XCTAssert(obj.createSignature(parameters: populationDict, key: "hogehoge") == "2fbfe87e54cc53036463633ef29beeaa4d740e435af586798917826d9e525112")
  }
  
}
