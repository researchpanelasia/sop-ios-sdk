//
//  HttpClient.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/16.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

final class HttpClient {
    
    static func postIdfa(Idfa: String, isLimitAdTrackingEnabled: Bool, completion: ((Bool) -> Void)?) {
        let request = Request()
        let url = URL(string: "http://aaaa.com")!
        let bodyString = "id=123&pw=456"
        request.post(url: url, requestBody: bodyString)
        
        if let completion = completion {
            completion(true)
        }
    }
    
    static func getSurvey() {
        
    }
    
}
