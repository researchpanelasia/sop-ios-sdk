//
//  ImplResearchTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class ImplResearchTests: XCTestCase {

  func testInit() throws {
    let jsonString = "{\"survey_id\": \"10000\",\n" +
      " \"quota_id\": \"20000\",\n" +
      " \"cpi\": \"1.23\",\n" +
      " \"ir\": \"80\",\n" +
      " \"loi\": \"10\"\n," +
      " \"is_answered\": \"1\",\n" +
      " \"is_closed\": \"1\",\n" +
      " \"title\": \"Example Research Survey\",\n" +
      " \"url\": \"https://partners.surveyon.com/resource/auth/v1_1?sig=e523d747983fb8adcfd858b432bc7d15490fae8f5ccb16c75f8f72e86c37672b&next=%2Fproject_survey%2F23456&time=1416302209&app_id=22&app_mid=test2\",\n" +
      " \"is_fixed_loi\": \"1\",\n" +
      " \"is_notifiable\": \"1\",\n" +
      " \"date\": \"2015-01-01\",\n" +
      " \"blocked_devices\": {\n" +
      "   \"PC\": 1\n" +
      " },\n" +
    " \"extra_info\": { }}"

    let json = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]

    let research = try ImplResearch(json: json)

    XCTAssertEqual(research.surveyId, "10000")
    XCTAssertEqual(research.title, "Example Research Survey")
    XCTAssertEqual(research.loi, "10")
    XCTAssertEqual(research.url, "https://partners.surveyon.com/resource/auth/v1_1?sig=e523d747983fb8adcfd858b432bc7d15490fae8f5ccb16c75f8f72e86c37672b&next=%2Fproject_survey%2F23456&time=1416302209&app_id=22&app_mid=test2")
    XCTAssertEqual(research.quotaId, "20000")
    XCTAssertEqual(research.cpi, "1.23")
    XCTAssertEqual(research.ir, "80")
    XCTAssertEqual(research.isAnswered, true)
    XCTAssertEqual(research.isClosed, true)
    XCTAssertEqual(research.isFixedLoi, true)
    XCTAssertEqual(research.isNotifiable, true)
    XCTAssertEqual(research.date, "2015-01-01")
    XCTAssertEqual(research.blockedDevices, ["PC":true])
  }

  func testLackOfStringValue(){
    let jsonString = "{\n" +
      " \"quota_id\": \"20000\",\n" +
      " \"cpi\": \"1.23\",\n" +
      " \"ir\": \"80\",\n" +
      " \"loi\": \"10\"\n," +
      " \"is_answered\": \"1\",\n" +
      " \"is_closed\": \"1\",\n" +
      " \"title\": \"Example Research Survey\",\n" +
      " \"url\": \"https://partners.surveyon.com/resource/auth/v1_1?sig=e523d747983fb8adcfd858b432bc7d15490fae8f5ccb16c75f8f72e86c37672b&next=%2Fproject_survey%2F23456&time=1416302209&app_id=22&app_mid=test2\",\n" +
      " \"is_fixed_loi\": \"1\",\n" +
      " \"is_notifiable\": \"1\",\n" +
      " \"date\": \"2015-01-01\",\n" +
      " \"blocked_devices\": {\n" +
      "   \"PC\": 1\n" +
      " },\n" +
    " \"extra_info\": { }}"

    let json = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]

    do {
      _ = try ImplResearch(json: json)
      XCTFail()
    } catch let e as ResearchInvalidDataError {
      print(e)
    } catch {
      XCTFail()
    }
  }

  func testLackOfBoolValue(){
    let jsonString = "{\"survey_id\": \"10000\",\n" +
      " \"quota_id\": \"20000\",\n" +
      " \"cpi\": \"1.23\",\n" +
      " \"ir\": \"80\",\n" +
      " \"loi\": \"10\"\n," +
      " \"is_answered\": \"1\",\n" +
      " \"is_closed\": \"1\",\n" +
      " \"title\": \"Example Research Survey\",\n" +
      " \"url\": \"https://partners.surveyon.com/resource/auth/v1_1?sig=e523d747983fb8adcfd858b432bc7d15490fae8f5ccb16c75f8f72e86c37672b&next=%2Fproject_survey%2F23456&time=1416302209&app_id=22&app_mid=test2\",\n" +
      " \"is_notifiable\": \"1\",\n" +
      " \"date\": \"2015-01-01\",\n" +
      " \"blocked_devices\": {\n" +
      "   \"PC\": 1\n" +
      " },\n" +
    " \"extra_info\": { }}"

    let json = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]

    do {
      _ = try ImplResearch(json: json)
      XCTFail()
    } catch let e as ResearchInvalidDataError {
      print(e)
    } catch {
      XCTFail()
    }
  }

  func testParseBlockDevice(){
    let parsed = ImplResearch.parseBlockedDevice(["PC":1])
    XCTAssertEqual(parsed, ["PC":true])
  }

  func testIsMobileBlocked() throws {
    let jsonString = "{\"survey_id\": \"10000\",\n" +
      " \"quota_id\": \"20000\",\n" +
      " \"cpi\": \"1.23\",\n" +
      " \"ir\": \"80\",\n" +
      " \"loi\": \"10\"\n," +
      " \"is_answered\": \"1\",\n" +
      " \"is_closed\": \"1\",\n" +
      " \"title\": \"Example Research Survey\",\n" +
      " \"url\": \"https://partners.surveyon.com/resource/auth/v1_1?sig=e523d747983fb8adcfd858b432bc7d15490fae8f5ccb16c75f8f72e86c37672b&next=%2Fproject_survey%2F23456&time=1416302209&app_id=22&app_mid=test2\",\n" +
      " \"is_fixed_loi\": \"1\",\n" +
      " \"is_notifiable\": \"1\",\n" +
      " \"date\": \"2015-01-01\",\n" +
      " \"blocked_devices\": {\n" +
      "   \"MOBILE\": 1\n" +
      " },\n" +
    " \"extra_info\": { }}"

    let json = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]

    let research = try ImplResearch(json: json)
    XCTAssertTrue(research.isMobileBlocked())
  }
}
