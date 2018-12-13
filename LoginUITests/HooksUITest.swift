//
//  Hooks.swift
//  GamesUITests
//
//  Created by Jhonnatan Macias on 12/12/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation

import XCTest
class HooksUITest {
    
    static func login(app: XCUIApplication) {
        self.loginViewCheckIntegrity(using: app)
        
    }
    
    static func existElement(using app: XCUIApplication, name text : String) {
        XCTAssertTrue(app.otherElements[text].exists)
    }
    
    static func isDisplayed(staticText text: String, using app: XCUIApplication) {
        let staticText = app.staticTexts[text]
        XCTAssertTrue(staticText.exists)
    }
    
    static func isDisplayed(button text: String, using app: XCUIApplication) {
        let button = app.buttons[text]
        XCTAssertTrue(button.exists)
    }
    
    static func click(button id: String, using app: XCUIApplication) {
        let button = app.buttons[id]
        button.tap()
    }
    
    
    private static func loginViewCheckIntegrity(using app: XCUIApplication) {
        self.isDisplayed(staticText: "welcome", using: app)
        self.isDisplayed(button: "continue", using: app)
    }
}
