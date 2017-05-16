//
//  RequestTests.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import XCTest
@testable import SurveyonPartners

class RequestTests: XCTestCase {

  var url: URL?
  var request: Request?

  override func setUp() {
    super.setUp()
    url = URL(string: "http://d8aspring.com")
    request = Request(url: url!)
  }

  func testSend500Error(){
    setupSend(statusCode: 500, data: nil, error: nil)

    request!.send(requestUrl: URLRequest(url: url!)) { (result) in
      switch result {
      case .success:
        XCTFail()
      case .failed(let error):
        XCTAssertEqual(error.response?.statusCode, 500)
        XCTAssertEqual(error.message, "Server error")
        XCTAssertNil(error.error)
      }
    }
  }

  func testSend500InvalidBody(){
    setupSend(statusCode: 200, data: "hoge", error: nil)

    request!.send(requestUrl: URLRequest(url: url!)) { (result) in
      switch result {
      case .success:
        XCTFail()
      case .failed(let error):
        XCTAssertEqual(error.response?.statusCode, 200)
        XCTAssertEqual(error.message, "Invalid response body")
        XCTAssertNotNil(error)
      }
    }
  }

  func testSend200(){
    setupSend(statusCode: 200, data: "{ \"meta\":{ \"code\": 200 }  }", error: nil)

    request!.send(requestUrl: URLRequest(url: url!)) { (result) in
      switch result {
      case .success(let response):
        XCTAssertEqual(response.statusCode, 200)
      case .failed:
        XCTFail()
      }
    }
  }

  func testAddHeaders() {
    var req = URLRequest(url: URL(string: "http://d8aspting.com")!)
    request!.addHeaders(request: &req, headers: ["hoge": "fuga"])
    XCTAssertEqual(req.value(forHTTPHeaderField: "hoge"), "fuga")
  }

  func setupSend(statusCode: Int, data: String?, error: Error?){
    let urlResponse = HTTPURLResponse(url: url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    let mockSession = MockSession(data: data?.data(using: .utf8), response: urlResponse, error: error)
    request!.urlSession = mockSession
  }

  class MockSession: URLSession {

    var data: Data?
    var response: URLResponse?
    var error: Error?
    var callback: ((Data?, URLResponse?, Error?) -> Void)?

    init(data: Data?, response: URLResponse?, error: Error?) {
      self.data = data
      self.response = response
      self.error = error
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
      self.callback = completionHandler
      return MockTask(self)
    }

    func doCallback(){
      callback?(data, response, error)
    }
  }

  class MockTask: URLSessionDataTask {
    weak var session: MockSession?
    init(_ session: MockSession){
      self.session = session
    }

    override func resume() {
      session?.doCallback()
    }
  }
}
