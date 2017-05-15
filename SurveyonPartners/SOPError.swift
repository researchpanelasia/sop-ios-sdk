//
//  SOPError.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

public class SOPError {
  public var message: String
  public var type: SOPErrorType
  public var response: Response?
  public var error: Error?

  public init(message: String, type: SOPErrorType, response: Response?, error: Error?) {
    self.message = message
    self.type = type
    self.response = response
    self.error = error
  }
}

public enum SOPErrorType {
  case InvalidConfiguration
  case NetworkNotAvailable
  case InvalidRequest
  case ConnectionError
  case ServerError
  case UnknownError
}
