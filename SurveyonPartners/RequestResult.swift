//
//  RequestResult.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public enum RequestResult {
  
  case success(statusCode: Int, message: String, rawBody: String)
  
  case failed(error: Error)
  
}