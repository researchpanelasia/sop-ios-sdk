//
//  Request.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class Request: RequestProtocol {
  
  static let ACCEPT = "Accept"
  
  static let CONTENT_TYPE = "Content-Type"
  
  static let APPLICATION_JSON = "application/json"
  
  static let X_SOP_SIG = "X-Sop-Sig"
  
  static let USER_AGENT = "User-Agent"
  
  var url: URL

  var headers = [String: String]()

  var requestBody: String

  var httpMethod: RequestHTTPMethod
  
  var verifyHost: Bool
  
  public init(url: URL,
              requestBody: String = "",
              httpMethod: RequestHTTPMethod = .GET,
              verifyHost: Bool = true) {
    self.url = url
    self.requestBody = requestBody
    self.httpMethod = httpMethod
    self.verifyHost = verifyHost
  }
  
  func send(requestUrl: URLRequest, completion: @escaping (RequestResult) -> Void) {
    
    let session = verifyHost ? URLSession.shared
                             : URLSession(configuration: URLSessionConfiguration.default, delegate: SSCAcceptingDelegate(), delegateQueue: OperationQueue())
    let task = session.dataTask(with: requestUrl) { data, response, error in

      if let error = error {
        completion(RequestResult.failed(error: SOPError(message: "Connection error", type: .ConnectionError, response: nil, error: error)))
        return
      }

      guard let httpResponse = response as? HTTPURLResponse else {
        completion(RequestResult.failed(error: SOPError(message: "Can't get response", type: .UnknownError, response: nil, error: nil)))
        return
      }

      let responseWrapper = Response(statusCode:httpResponse.statusCode, data: data)

      if 400 <= responseWrapper.statusCode && responseWrapper.statusCode < 500 {
        completion(RequestResult.failed(error: SOPError(message: "Invalid request", type: .InvalidRequest, response: responseWrapper, error: nil)))
        return
      }

      if responseWrapper.statusCode < 200 && 500 <= responseWrapper.statusCode {
        completion(RequestResult.failed(error: SOPError(message: "Server error", type: .ServerError, response: responseWrapper, error: nil)))
        return
      }

      guard let data = data else {
        completion(RequestResult.failed(error: SOPError(message: "Invalid response body", type: .ServerError, response: responseWrapper, error: nil)))
        return
      }

      do {
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let meta = json?[Constants.KEY_META] as? [String: Int] else {
          completion(RequestResult.failed(error: SOPError(message: "Invalid response body", type: .ServerError, response: responseWrapper, error: nil)))
          return
        }
        if meta[Constants.KEY_CODE] != 200 {
          completion(RequestResult.failed(error: SOPError(message: "Invalid response body", type: .ServerError, response: responseWrapper, error: nil)))
          return
        }
        completion(RequestResult.success(response: responseWrapper))
        return
      } catch let e {
        completion(RequestResult.failed(error: SOPError(message: "Server error", type: .ServerError, response: responseWrapper, error: e)))
        return
      }
    }
    task.resume()
  }
  
  class SSCAcceptingDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
      let credential = challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust ? URLCredential(trust: challenge.protectionSpace.serverTrust!) : nil
      completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
    }
  }
  
  func getHttpMethod() -> String {
    switch httpMethod {
    case RequestHTTPMethod.POST:
      return "POST"
    default:
      return "GET"
    }
  }

  func addHeader(key: String, value: String){
    headers[key] = value
  }
}

extension Request {

  func post(completion: @escaping (RequestResult) -> Void) {
    var request = URLRequest(url: url)
    request.httpMethod = getHttpMethod()
    addHeaders(request: &request, headers: headers)
    request.httpBody = requestBody.data(using: .utf8)
    
    send(requestUrl: request, completion: completion)
  }
  
  func get(completion: @escaping (RequestResult) -> Void) {
    var request = URLRequest(url: url)
    request.httpMethod = getHttpMethod()
    
    send(requestUrl: request, completion: completion)
  }

  func addHeaders(request: inout URLRequest, headers: [String: String]){
    _ = headers.map { (key: String, value: String) in
      request.addValue(value, forHTTPHeaderField: key)
    }
  }
}
