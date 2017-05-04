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

public enum RequestHTTPMethod: String {
  case GET = "GET"
  case POST = "POST"
}
