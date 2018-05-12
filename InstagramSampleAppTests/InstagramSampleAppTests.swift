//
//  InstagramSampleAppTests.swift
//  InstagramSampleAppTests
//
//  Created by Mohammad Farhoudi on 19/02/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import XCTest
@testable import InstagramSampleApp

class InstagramSampleAppTests: XCTestCase {
    
    
    func testTimeAgoString() {
        
        let fiveMinutesAgo = Date(timeIntervalSinceNow: -5 * 60)
        let fiveMinutesAgoDisplay = fiveMinutesAgo.timeAgoDisplay()
        XCTAssertEqual(fiveMinutesAgoDisplay, "5 minutes ago")
        
        
    }
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
