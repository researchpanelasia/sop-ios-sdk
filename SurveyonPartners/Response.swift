//
//  Response.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class Response {
    var statusCode: Int
    var rawBody: String
    
    
    init(statusCode: Int, rawBody: String) {
        self.statusCode = statusCode
        self.rawBody = rawBody
    }
    
    func getStatusCode() -> Int {
        return self.statusCode
    }
    
    func getRawBody() -> String {
        return self.rawBody
    }
    
    func getJsonBody() -> String {
        
//        let request = NSMutableURLRequest(url: ""!)
        return self.rawBody
    }
    
}
