//
//  Response.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

public class Response {
  public var statusCode: Int
  public var data: Data?

  init(statusCode: Int, data: Data?){
    self.statusCode = statusCode
    self.data = data
  }

  func stringData() -> String {
    guard let data = data else {
      return ""
    }
    return String(data: data, encoding: .utf8) ?? ""
  }
}
