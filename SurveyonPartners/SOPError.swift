//
//  SOPError.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

public class SOPError : NSObject {
  public var message: String
  public var type: SOPErrorType
  public var response: Response?
  public var error: Error?

  override public var description: String {
    let stringData = response?.stringData() ?? ""
    return message + ", "
      + type.toString() +  ", "
      + String(describing: response?.statusCode) + ", "
      + stringData + ", "
      + String(describing: error)
  }

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

  public func toString() -> String {
    switch self {
    case .InvalidConfiguration:
      return "InvalidConfiguration"
    case .NetworkNotAvailable:
      return "NetworkNotAvailable"
    case .InvalidRequest:
      return "InvalidRequest"
    case .ConnectionError:
      return "ConnectionError"
    case .ServerError:
      return "ServerError"
    case .UnknownError:
      return "UnknownError"
    }
  }
}
