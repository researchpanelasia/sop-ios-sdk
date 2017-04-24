//
//  RequestProtocol.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public protocol RequestProtocol {
  
  var url: URL { get }
  
  var requestBody: String { get }
  
  var httpMethod: RequestHTTPMethod { get }
  
}

/**
 Represents HTTP methods that could be used to issue `RequestProtocol`.
 */
public enum RequestHTTPMethod: String {
  /// `GET` graph request HTTP method.
  case GET = "GET"
  /// `POST` graph request HTTP method.
  case POST = "POST"
}
