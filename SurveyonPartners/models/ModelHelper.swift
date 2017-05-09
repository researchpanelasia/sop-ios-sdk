//
//  ModelHelper.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

struct InvalidResponseError :Error {
}

class ModelHelper {
  static func getString(_ string: String?) throws -> String {
    guard let value = string else {
      throw InvalidResponseError()
    }
    return value
  }
}
