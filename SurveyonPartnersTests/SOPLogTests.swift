import XCTest
@testable import SurveyonPartners

class SOPLogTests: XCTestCase {
  
  var destination: MockDestination?
  
  override func setUp() {
    super.setUp()
    destination = MockDestination()
    SOPLog.destination = destination
  }
  
  override func tearDown() {
    super.tearDown()
    SOPLog.loadDefaultDestination()
  }
  
  func testDebug() {
    SOPLog.debug(message: "hoge")
    XCTAssert(matchMessage(regex: "\\[DEBUG\\] \"hoge\" \\d\\d\\d\\d/\\d\\d/\\d\\d \\d\\d:\\d\\d:\\d\\d L\\d+ testDebug\\(\\)"))
  }
  
  func testInfo() {
    SOPLog.info(message: "hoge")
    XCTAssert(matchMessage(regex: "\\[INFO\\] \"hoge\" \\d\\d\\d\\d/\\d\\d/\\d\\d \\d\\d:\\d\\d:\\d\\d L\\d+ testInfo\\(\\)"))
  }

  func testWarning() {
    SOPLog.warning(message: "hoge")
    XCTAssert(matchMessage(regex: "\\[WARNING\\] \"hoge\" \\d\\d\\d\\d/\\d\\d/\\d\\d \\d\\d:\\d\\d:\\d\\d L\\d+ testWarning\\(\\)"))
  }
  
  func testError() {
    SOPLog.error(message: "hoge")
    XCTAssert(matchMessage(regex: "\\[ERROR\\] \"hoge\" \\d\\d\\d\\d/\\d\\d/\\d\\d \\d\\d:\\d\\d:\\d\\d L\\d+ testError\\(\\)"))
  }

  func matchMessage(regex: String) -> Bool{
    let re = try? NSRegularExpression(pattern: regex)
    let message = destination?.shift()
    let number = re?.numberOfMatches(in: message!, range: NSMakeRange(0, message!.characters.count))
    return number == 1
  }
  
  class MockDestination: LogDestination {
    private var messageQueue: [String] = []
    
    func log(_ message: String) {
      messageQueue.append(message)
    }
    
    func shift() -> String {
      let message = messageQueue[0]
      messageQueue = Array(messageQueue[1..<messageQueue.count])
      return message
    }
  }
}
