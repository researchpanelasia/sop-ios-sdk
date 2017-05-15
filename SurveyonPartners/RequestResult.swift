//
//  RequestResult.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public enum RequestResult {
  
  case success(response: Response)
  
  case failed(error: SOPError)
}
