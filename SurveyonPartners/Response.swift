//
//  Response.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

//class Response {
//    var statusCode: Int
//    var rawBody: String
//    
//    
//    init(statusCode: Int, rawBody: String) {
//        self.statusCode = statusCode
//        self.rawBody = rawBody
//    }
//    
//    func getStatusCode() -> Int {
//        return self.statusCode
//    }
//    
//    func getRawBody() -> String {
//        return self.rawBody
//    }
//    
//    func getJsonBody() -> String {
//        
////        let request = NSMutableURLRequest(url: ""!)
//        return self.rawBody
//    }
//    
//}


public struct Response: ResponseProtocol {
    fileprivate let rawResponse: Any?
    
    /**
     Initializes a `GraphResponse`.
     
     - parameter rawResponse: Raw response received from a server.
     Usually is represented by either a `Dictionary` or `Array`.
     */
    public init(rawResponse: Any?) {
        self.rawResponse = rawResponse
    }
    
    /**
     Converts and returns a response in a form of `Dictionary<String, Any>`.
     If the conversion fails or there is was response - returns `nil`.
     */
    public var dictionaryValue: [String : Any]? {
        return rawResponse as? [String : Any]
    }
    
    /**
     Converts and returns a response in a form of `Array<Any>`
     If the conversion fails or there is was response - returns `nil`.
     */
    public var arrayValue: [Any]? {
        return rawResponse as? [Any]
    }
    
    /**
     Converts and returns a response in a form of `String`.
     If the conversion fails or there is was response - returns `nil`.
     */
    public var stringValue: String? {
        return rawResponse as? String
    }
}
