//
//  UnitlyUITests.swift
//  UnitlyUITests
//
//  Created by FGT MAC on 4/4/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import XCTest


class UnitlyUITests: XCTestCase {

    func testDistance() {
        let app = XCUIApplication()
        app.activate()
        
        //Top TextField
        let topTextField = app.textFields["ViewController.topTextField"]
        topTextField.tap()
        topTextField.typeText("1")
        
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
        
        //Bottom TextField
        let bottomTextField = app.textFields["ViewController.bottomTextField"]
        bottomTextField.tap()
        bottomTextField.typeText("1")
        
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
    }
    
    func testToolbarButtons() {
        
        let app = XCUIApplication()
        app.activate()
        let toolbar = app.toolbars["Toolbar"]
        
        toolbar.buttons["temperature"].tap()
        toolbar.buttons["lenght"].tap()
        toolbar.buttons["volume"].tap()
        toolbar.buttons["weight"].tap()
        toolbar.buttons["distance"].tap()
        toolbar.buttons["lenght2"].tap()
        
    }
}
