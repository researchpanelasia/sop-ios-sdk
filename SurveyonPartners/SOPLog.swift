//
//  SOPLog.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class SOPLog{
  
  static let debugLevel = "SopDebugLevel"
  
  static var destination: LogDestination? = StdoutDestination()
  static var level = getDebugLevel()
  
  static func debug(
    message: String,
    function: String = #function,
    file: String = #function,
    line: Int = #line) { SOPLog.write(level: .debug, message: message, function: function, file: file, line: line) };
  static func info(
    message: String,
    function: String = #function,
    file: String = #function,
    line: Int = #line) { SOPLog.write(level: .info, message: message, function: function, file: file, line: line) };
  static func warning(
    message: String,
    function: String = #function,
    file: String = #file,
    line: Int = #line) { SOPLog.write(level: .warning, message: message, function: function, file: file, line: line) };
  static func error(
    message: String,
    function: String = #function,
    file: String = #file,
    line: Int = #line) { SOPLog.write(level: .error, message: message, function: function, file: file, line: line) };
  
  static func write(
    level: Level,
    message: String,
    function: String,
    file: String,
    line: Int) {
    
    if level.rawValue < self.level.rawValue {
      return
    }
    
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
    destination?.log("[\(level.name)] \"\(message)\" \(nowdate) L\(line) \(function) @\(filename)")
  }
  
  static func loadDefaultSetting(){
    destination = StdoutDestination()
    level = .none
  }
  
  static func getDebugLevel() -> Level {
    guard let dict = Utility.getPlistDictionary(),
      let debugLivel = dict[debugLevel] as? Int else {
        return .none
    }
    
    switch debugLivel {
    case 0:
      return Level.debug
    case 1:
      return Level.info
    case 2:
      return Level.warning
    case 3:
      return Level.error
    case 4:
      return Level.none
    default:
      return Level.none
    }
  }
  
  enum Level: Int {
    case debug = 0
    case info = 1
    case warning = 2
    case error = 3
    case none = 4
    
    var name: String {
      switch self {
      case .debug:
        return "DEBUG"
      case .info:
        return "INFO"
      case .warning:
        return "WARNING"
      case .error:
        return "ERROR"
      case .none:
        return "NONE"
      }
    }
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
