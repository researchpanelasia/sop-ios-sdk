//
//  SurveyonPartnersTests.swift
//  SurveyonPartnersTests
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import SurveyonPartners

class SurveyonPartnersTests: XCTestCase {
  override func tearDown(){
    super.tearDown()
    SurveyonPartners.initConfig()
    PreferencesManager.writePreferences(value: 0, forKey: Constants.SURVEYON_PARTNERS)
  }

  func testGetSurveyListWith200(){
    stub(condition: isHost("partners.surveyon.com"), response: { _ in
      let json = ["meta": ["code":200,"message":""]
        ,"data":
          ["profiling":[]
            ,"research":[]]]
      return OHHTTPStubsResponse(jsonObject: json, statusCode:200, headers:nil)
    })

    stub(condition: isHost("console.partners.surveyon.com"), response: { _ in
      let json = ["meta": ["code":200,"message":""]]
      return OHHTTPStubsResponse(jsonObject: json, statusCode:200, headers:nil)
    })

    let semaphore = DispatchSemaphore(value: 0)

    SurveyonPartners.setUp(appId: "hoge", appMid: "fuga", secretKey: "bar")
    SurveyonPartners.getSurveyList { (result: RequestResult) in
      switch result {
      case .success(let response):
        XCTAssertEqual(response.statusCode, 200)
      case .failed:
        XCTFail()
      }
      semaphore.signal()
    }

    semaphore.wait()
  }

  func testGetSurveyListWith500(){
    stub(condition: isHost("partners.surveyon.com"), response: { _ in
      return OHHTTPStubsResponse(data: Data(), statusCode:500, headers:nil)
    })

    stub(condition: isHost("console.partners.surveyon.com"), response: { _ in
      let json = ["meta": ["code":200,"message":""]]
      return OHHTTPStubsResponse(jsonObject: json, statusCode:200, headers:nil)
    })

    let semaphore = DispatchSemaphore(value: 0)

    SurveyonPartners.setUp(appId: "hoge", appMid: "fuga", secretKey: "bar")
    SurveyonPartners.getSurveyList { (result: RequestResult) in
      switch result {
      case .success:
        XCTFail()
      case .failed(let error):
        XCTAssertEqual(error.message, "Server error")
      }
      semaphore.signal()
    }

    semaphore.wait()
  }

  func testGetSurveyListWithInvalidResponse(){
    stub(condition: isHost("partners.surveyon.com"), response: { _ in
      return OHHTTPStubsResponse(data: "hoge".data(using: .utf8)!, statusCode:200, headers:nil)
    })

    stub(condition: isHost("console.partners.surveyon.com"), response: { _ in
      let json = ["meta": ["code":200,"message":""]]
      return OHHTTPStubsResponse(jsonObject: json, statusCode:200, headers:nil)
    })

    let semaphore = DispatchSemaphore(value: 0)

    SurveyonPartners.setUp(appId: "hoge", appMid: "fuga", secretKey: "bar")
    SurveyonPartners.getSurveyList { (result: RequestResult) in
      switch result {
      case .success:
        XCTFail()
      case .failed(let error):
        XCTAssertEqual(error.message, "Invalid response body")
      }
      semaphore.signal()
    }

    semaphore.wait()
  }

  func testGetSurveyList500NoEnum(){
    stub(condition: isHost("partners.surveyon.com"), response: { _ in
      return OHHTTPStubsResponse(data: Data(), statusCode:500, headers:nil)
    })

    stub(condition: isHost("console.partners.surveyon.com"), response: { _ in
      let json = ["meta": ["code":200,"message":""]]
      return OHHTTPStubsResponse(jsonObject: json, statusCode:200, headers:nil)
    })

    let semaphore = DispatchSemaphore(value: 0)

    SurveyonPartners.setUp(appId: "hoge", appMid: "fuga", secretKey: "bar")
    SurveyonPartners.getSurveyList { (response, error) in
      XCTAssertEqual(error?.response?.statusCode, 500)
      XCTAssertEqual(error?.message, "Server error")
      semaphore.signal()
    }

    semaphore.wait()
  }

  func testGetSurveyList200NoEnum(){
    stub(condition: isHost("partners.surveyon.com"), response: { _ in
      let json = ["meta": ["code":200,"message":""]
        ,"data":
          ["profiling":[]
            ,"research":[]]]
      return OHHTTPStubsResponse(jsonObject: json, statusCode:200, headers:nil)
    })

    stub(condition: isHost("console.partners.surveyon.com"), response: { _ in
      let json = ["meta": ["code":200,"message":""]]
      return OHHTTPStubsResponse(jsonObject: json, statusCode:200, headers:nil)
    })

    let semaphore = DispatchSemaphore(value: 0)

    SurveyonPartners.setUp(appId: "hoge", appMid: "fuga", secretKey: "bar")
    SurveyonPartners.getSurveyList { (response, error) in
      XCTAssertNil(error)
      XCTAssertEqual(response?.statusCode, 200)
      semaphore.signal()
    }

    semaphore.wait()
  }
}
