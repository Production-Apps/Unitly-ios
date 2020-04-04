//
//  UnitlyUITests.swift
//  UnitlyUITests
//
//  Created by FGT MAC on 4/4/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import XCTest


class UnitlyUITests: XCTestCase {
    
    //Helper computed property to be DRY
    private var app: XCUIApplication {
        return XCUIApplication()
    }
    
    
    override func setUp() {
        //Stop if a test fails
        continueAfterFailure = false
        
        //Lanch app
        app.activate()
    }
    
    
    func testTextFields() {
        
        //Top TextField
        let topTextField = app.textFields["ViewController.topTextField"]
        let bottomTextField = app.textFields["ViewController.bottomTextField"]
        
        topTextField.tap()
        topTextField.typeText("1")
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
        
        //Check result
        XCTAssertNotNil(bottomTextField.value)
        
        //Bottom TextField
        bottomTextField.tap()
        bottomTextField.typeText("1")
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
        
        //Check result
        XCTAssertNotNil(topTextField.value)
    }
    
    
    func testLabels() {
        let topLabel = app.staticTexts["topLabel"]
        let bottomLabel = app.staticTexts["bottomLabel"]
        
        XCTAssertEqual(topLabel.label, "Miles")
        XCTAssertEqual(bottomLabel.label, "KM")
    }
    
    
    func testToolbarButtons() {
        
        let toolbar = app.toolbars["Toolbar"]
        
        toolbar.buttons["temperature"].tap()
        toolbar.buttons["lenght"].tap()
        toolbar.buttons["volume"].tap()
        toolbar.buttons["weight"].tap()
        toolbar.buttons["lenght2"].tap()
        toolbar.buttons["distance"].tap()
  
    }
    
   
    
}
