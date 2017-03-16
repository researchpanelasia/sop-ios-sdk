//
//  Request.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class Request {
    
    func send(request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error = \(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("httpStatus.statusCode =  \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    func post(url: URL, requestBody: String) {
//        var request = URLRequest(url: URL(string: "http://aaaa.com")!)
//        let postString = "id=13&name=Jack"
        var request = URLRequest(url: url)
        request.httpMethod = MethodType.POST
        request.httpBody = requestBody.data(using: .utf8)
        
        send(request: request)
    }
    
    func get(url: URL, requestBody: String) {
        var request = URLRequest(url: url)
        request.httpMethod = MethodType.GET
        request.httpBody = requestBody.data(using: .utf8)
        
        send(request: request)
    }
    
}
