//
//  Request.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class Request: RequestProtocol {
  
  static let ACCEPT = "Accept"
  
  static let CONTENT_TYPE = "Content-Type"
  
  static let APPLICATION_JSON = "application/json"
  
  static let X_SOP_SIG = "X-Sop-Sig"
  
  static let USER_AGENT = "User-Agent"
  
  public var url: URL
  
  public var requestBody: String
  
  public var httpMethod: RequestHTTPMethod
  
  public init(url: URL,
              requestBody: String = "",
              httpMethod: RequestHTTPMethod = .GET) {
    self.url = url
    self.requestBody = requestBody
    self.httpMethod = httpMethod
  }
  
  func send(requestUrl: URLRequest, completion: ((Bool) -> Void)?) {
    let operationQueue = OperationQueue()
    let configuration = URLSessionConfiguration.default
    //      let session = URLSession(configuration: configuration)
    let session = URLSession(configuration: configuration, delegate: NSURLSessionPinningDelegate(), delegateQueue: operationQueue)
    let task = session.dataTask(with: requestUrl) { data, response, error in
      //        let task = URLSession.shared.dataTask(with: requestUrl) { data, response, error in
      
      guard let data = data, error == nil else {
        if let completion = completion {
          // check for fundamental networking error
          completion(false)
        }
        return
      }
      
      if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode < 200, httpStatus.statusCode >= 300 {
        // check for http errors
        SOPLog.error(message: "response = \(response)")
        SOPLog.error(message: "httpStatus.statusCode = \(httpStatus.statusCode)")
        let errorString = String(data: data, encoding: .utf8)
        SOPLog.error(message: "errorString = \(errorString)")
        
        if let completion = completion {
          completion(false)
        }
        return
      }
      
      let responseString = String(data: data, encoding: .utf8)
      if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
        let meta = json?["meta"] as? [String:Any],
        let code = meta["code"] as? Int,
        let message = meta["message"] as? String {
        SOPLog.debug(message: "code = \(code)")
        SOPLog.debug(message: "message = \(message)")
      } else {
        SOPLog.error(message: "bad json")
      }
      
      SOPLog.debug(message: "responseString = \(responseString)")
      if let completion = completion {
        completion(true)
      }
    }
    task.resume()
  }
  
  class NSURLSessionPinningDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
      
      if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        if let trust = challenge.protectionSpace.serverTrust,
          let pem = Bundle.main.path(forResource: "https", ofType: "cer"),
          let data = NSData(contentsOfFile: pem),
          let cert = SecCertificateCreateWithData(nil, data) {
          let certs = [cert]
          SecTrustSetAnchorCertificates(trust, certs as CFArray)
          return
        }
      }
      
      completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
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

}

extension Request {
  
  func post(completion: ((Bool) -> Void)?) {
    var request = URLRequest(url: url)
    request.httpMethod = getHttpMethod()
    request.addValue(Request.APPLICATION_JSON, forHTTPHeaderField: Request.CONTENT_TYPE)
    request.addValue(Authentication().createSignature(message: requestBody, key: SetupInfo.secretKey!), forHTTPHeaderField: Request.X_SOP_SIG)
    request.addValue(Utility.getUserAgent(), forHTTPHeaderField: Request.USER_AGENT)
    request.httpBody = requestBody.data(using: .utf8)
    
    send(requestUrl: request, completion: completion)
  }
  
  func get(completion: ((Bool) -> Void)?) {
    var request = URLRequest(url: url)
    request.httpMethod = getHttpMethod()
    
    send(requestUrl: request, completion: completion)
    
  }
  
}
