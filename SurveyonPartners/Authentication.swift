//
//  Authentication.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import CommonCrypto

class Authentication {
    
    func createSignature(parameters: [String: String], key: String) -> String {
        return createHmacSHA256(message: createCombinedParameter(parameters: parameters), key: key)
    }
    
    func createSignature(message: String, key: String) -> String {
        return createHmacSHA256(message: message, key: key)
    }
    
    private func createCombinedParameter(parameters: [String: String]) -> String {
        let str = parameters.sorted(by: {$0.0 < $1.0})
            .filter({!$0.0.hasPrefix(Constants.PREFIX_SOP_)})
            .reduce("", {result, element in result + "&" + element.key + "=" + element.value })
        
        return str.substring(from: str.index(str.startIndex, offsetBy: 1))
    }
    
    private func createHmacSHA256(message: String, key: String) -> String {
        let str = message.cString(using: String.Encoding.utf8)
        let strLen = Int(message.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyStr, keyLen, str!, strLen, result)
        let digest = stringFromResult(result: result, length: digestLen)
        result.deallocate(capacity: digestLen)
        
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    
}
