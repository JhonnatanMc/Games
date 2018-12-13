//
//  LoginUITests.swift
//  LoginUITests
//
//  Created by Jhonnatan Macias on 12/12/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
        app.launch()
    }
    
    
    func testLoginIntegrity() {
        HooksUITest.login(app: app)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
