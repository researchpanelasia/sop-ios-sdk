//
//  SOPLog.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class SOPLog{
  
  static var destination: LogDestination? = StdoutDestination()
  
  static func debug(
    message: String,
    function: String = #function,
    file: String = #function,
    line: Int = #line) { SOPLog.write(loglevel: "[DEBUG]", message: message, function: function, file: file, line: line) };
  static func info(
    message: String,
    function: String = #function,
    file: String = #function,
    line: Int = #line) { SOPLog.write(loglevel: "[INFO]", message: message, function: function, file: file, line: line) };
  static func warning(
    message: String,
    function: String = #function,
    file: String = #file,
    line: Int = #line) { SOPLog.write(loglevel: "[WARNING]", message: message, function: function, file: file, line: line) };
  static func error(
    message: String,
    function: String = #function,
    file: String = #file,
    line: Int = #line) { SOPLog.write(loglevel: "[ERROR]", message: message, function: function, file: file, line: line) };
  
  static func write(
    loglevel: String,
    message: String,
    function: String,
    file: String,
    line: Int) {
    
    let now = NSDate()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ja_JP")
    dateFormatter.timeStyle = .medium
    dateFormatter.dateStyle = .medium
    
    let nowdate = dateFormatter.string(for: now)!
    
    var filename = file
    if let match = filename.range(of: "[^/]*$") {
      filename = filename.substring(with: match)
    }
    destination?.log("\(loglevel) \"\(message)\" \(nowdate) L\(line) \(function) @\(filename)")
  }
  
  static func loadDefaultDestination(){
    destination = StdoutDestination()
  }
}

protocol LogDestination {
  func log(_ message: String)
}

class StdoutDestination: LogDestination {
  func log(_ message: String) {
    print(message)
  }
}
