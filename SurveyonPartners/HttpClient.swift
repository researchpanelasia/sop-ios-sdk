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
    
    public class Builder {
        private static var InternalAppId: String = ""
        private static var InternalAppMid: String = ""
        private static var InternalSecretKey: String = ""
        private static var InternalHost: String = ""
        private static var InternalUserAgent: String = ""
        private static var InternalVerifyHost: Bool = true
        private static var InternalProtocolType: String = Constants.HTTPS
        private static var InternalPosixTime: String = SurveyonPartnersCommom.getPosixTime()
        
        public static var appId: String {
            get {
                return InternalAppId
            }
            set {
                InternalAppId = newValue
            }
        }
        
        public static var appMid: String {
            get {
                return InternalAppMid
            }
            set {
                InternalAppMid = newValue
            }
        }
        
        public static var secretKey: String {
            get {
                return InternalSecretKey
            }
            set {
                InternalSecretKey = newValue
            }
        }
        
        public static var host: String {
            get {
                return InternalHost
            }
            set {
                InternalHost = newValue
            }
        }
        
        public static var userAgent: String {
            get {
                return InternalUserAgent
            }
            set {
                InternalUserAgent = newValue
            }
        }
    }
    
}
