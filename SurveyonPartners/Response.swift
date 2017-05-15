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
  public var error: NSError?

  init(statusCode: Int, data: Data?, error: NSError?){
    self.statusCode = statusCode
    self.data = data
    self.error = error
  }
}
