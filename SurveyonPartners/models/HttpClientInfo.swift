//
//  HttpClientInfo.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/17.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

final public class HttpClientInfo {
    
    private var host: String
    private var userAgent: String
    private var useHttps: String
    
    init(host: String, userAgent:String, useHttps: String) {
        self.host = host
        self.userAgent = userAgent
        self.useHttps = useHttps
    }
    
    public func getHost() -> String { return self.host }
    
    public func getUserAgent() -> String { return self.userAgent }
    
    public func getUseHttp() -> String { return self.useHttps }
    
}
