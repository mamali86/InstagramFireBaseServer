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
    
    var user: UserInfo!
    
    func testTimeAgoString() {
        
        let fiveMinutesAgo = Date(timeIntervalSinceNow: -5 * 60)
        let fiveMinutesAgoDisplay = fiveMinutesAgo.timeAgoDisplay()
        XCTAssertEqual(fiveMinutesAgoDisplay, "5 mins ago")
        
        
    }
    
    func testuserInfoTest(){
        
        let uid = "hdyiwjdhgu889ej"
        
        XCTAssertEqual(uid, user.uid)
        
    }
    
    
    
    override func setUp() {
        super.setUp()
        
        user = UserInfo(uid: "hdyiwjdhgu889ej", dictionary: ["Username": "Ali"])
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
        
        user = nil

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
