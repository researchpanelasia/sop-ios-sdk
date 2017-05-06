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
  
  func send(requestUrl: URLRequest, completion: ((RequestResult) -> Void)?) {
    
    let session = verifyHost ? URLSession.shared
                             : URLSession(configuration: URLSessionConfiguration.default, delegate: SSCAcceptingDelegate(), delegateQueue: OperationQueue())
    let task = session.dataTask(with: requestUrl) { data, response, error in
      
      guard let data = data, error == nil else {
        // check for fundamental networking error
        SOPLog.error(message: "network error")
        if let completion = completion {
          completion(RequestResult.failed(error: error!))
        }
        return
      }
      
      if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode < 200, httpStatus.statusCode >= 300 {
        // check for http errors
        let errorString = String(data: data, encoding: .utf8)
        SOPLog.error(message: "response = \(response!), statusCode = \(httpStatus.statusCode), errorString = \(errorString!)")
        if let completion = completion {
          completion(RequestResult.failed(error: error!))
        }
        return
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
        let meta = json?[Constants.KEY_META] as? [String:Any]
        let code = meta?[Constants.KEY_CODE] as? Int
        let message = meta?[Constants.KEY_MESSAGE] as? String
        
        if let completion = completion {
          completion(RequestResult.success(statusCode: code!, message: message!, rawBody: data))
        }
        return
      } catch let parseError {
        completion!(RequestResult.failed(error: parseError))
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
}

extension Request {
  
  func post(completion: ((RequestResult) -> Void)?) {
    var request = URLRequest(url: url)
    request.httpMethod = getHttpMethod()
    request.addValue(Request.APPLICATION_JSON, forHTTPHeaderField: Request.CONTENT_TYPE)
    
    request.addValue(Authentication().createSignature(message: requestBody, key: SurveyonPartners.setupInfo!.secretKey!), forHTTPHeaderField: Request.X_SOP_SIG)
    request.addValue(Utility.getUserAgent(), forHTTPHeaderField: Request.USER_AGENT)
    request.httpBody = requestBody.data(using: .utf8)
    
    send(requestUrl: request, completion: completion)
  }
  
  func get(completion: ((RequestResult) -> Void)?) {
    var request = URLRequest(url: url)
    request.httpMethod = getHttpMethod()
    
    send(requestUrl: request, completion: completion)
  }
  
}
