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
        
        let toolbar = app.toolbars["Toolbar"]
        toolbar.buttons["distance"].tap()
        
        //Top TextField
        let topTextField = app.textFields["ViewController.topTextField"]
        let bottomTextField = app.textFields["ViewController.bottomTextField"]
        
        topTextField.tap()
        topTextField.typeText("1")
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()

        //Check result
        XCTAssertEqual(topTextField.value as! String, "1")
        XCTAssertEqual(bottomTextField.value as! String, "1.61")
        
        //Bottom TextField
        bottomTextField.tap()
        bottomTextField.typeText("1")
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
        
        //Check result
        XCTAssertEqual(topTextField.value as! String, "0.62")
        XCTAssertEqual(bottomTextField.value as! String, "1")
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
        toolbar.buttons["length"].tap()
        toolbar.buttons["volume"].tap()
        toolbar.buttons["weight"].tap()
        toolbar.buttons["length2"].tap()
        toolbar.buttons["distance"].tap()

    }
    
    
    func testResetButton() {
        //Top TextField
        let topTextField = app.textFields["ViewController.topTextField"]
        let bottomTextField = app.textFields["ViewController.bottomTextField"]
        
        topTextField.tap()
        topTextField.typeText("1")
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
        
        //Clear fields
        app/*@START_MENU_TOKEN@*/.staticTexts["Clear"]/*[[".buttons[\"Clear\"].staticTexts[\"Clear\"]",".buttons[\"ViewController.clearButton\"].staticTexts[\"Clear\"]",".staticTexts[\"Clear\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        //Check result
        XCTAssertNotEqual(topTextField.value as! String, "1")
        XCTAssertEqual(bottomTextField.value as! String, "")
    }
    
    func testStringInput() {
        
        let toolbar = app.toolbars["Toolbar"]
        toolbar.buttons["volume"].tap()
        
        
        //Top TextField
        let topTextField = app.textFields["ViewController.topTextField"]
        let bottomTextField = app.textFields["ViewController.bottomTextField"]
        
        topTextField.tap()
        topTextField.typeText("this is a string test")
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()

        //Check result
        XCTAssertEqual(bottomTextField.value as! String, "")
    }
    
   
    
}
