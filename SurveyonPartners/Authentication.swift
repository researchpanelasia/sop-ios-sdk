//
//  Authentication.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import SOPCrypto

class Authentication {
  func createSignature(parameters: [String: String], key: String) -> String {
    return SOPCrypto.hmacSha256(createCombinedParameter(parameters: parameters), key: key)
  }

  func createSignature(message: String, key: String) -> String {
    return SOPCrypto.hmacSha256(message, key: key)
  }

  private func createCombinedParameter(parameters: [String: String]) -> String {
    let str = parameters.sorted(by: {$0.0 < $1.0})
      .filter({!$0.0.hasPrefix(Constants.PREFIX_SOP_)})
      .reduce("", {result, element in result + "&" + element.key + "=" + element.value })
    
    return str.substring(from: str.index(str.startIndex, offsetBy: 1))
  }
}
