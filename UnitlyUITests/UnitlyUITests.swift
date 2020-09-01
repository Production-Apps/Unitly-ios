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
    
    func testInputValueLabel() {
        app.buttons["SpeedButton"].tap()
        
        app.buttons["Button1"].tap()
        app.buttons["Button2"].tap()
        app.buttons["Button3"].tap()
        app.buttons["Button4"].tap()

        //input TextField
        let inputTextField = app.staticTexts["InputTextField"]
    
        //Check input
        XCTAssertEqual(inputTextField.label, "1,234")
    }
    
    func testClearFieldButton() {
        let inputTextField = app.staticTexts["InputTextField"]
        
        app.buttons["LengthButton"].tap()
        
        app.buttons["Button3"].tap()
        app.buttons["Button4"].tap()
        //Clear Field
        app.buttons["ClearFieldButton"].tap()
        //Check if is 0
        XCTAssertEqual(inputTextField.label, "0")
    }
    
    func testResultValueLabel(){
        let resultLabel =  app.staticTexts["ResultValue"]
        
        app.buttons["VolumeButton"].tap()
        
        app.buttons["Button1"].tap()
        
        XCTAssertEqual(resultLabel.label, "0.26")
        
    }
    
    func testNumbers() {
        let resultLabel = app.staticTexts["InputTextField"]
        
        app.buttons["WeightButton"].tap()
        
        app.buttons["Button1"].tap()
        app.buttons["Button2"].tap()
        app.buttons["Button3"].tap()
        app.buttons["Button4"].tap()
        app.buttons["Button5"].tap()
        app.buttons["Button6"].tap()
        app.buttons["Button7"].tap()
        app.buttons["Button8"].tap()
        app.buttons["Button9"].tap()
        
        XCTAssertEqual(resultLabel.label, "123,456,789")
        
    }
    
    func testBackSpaceButton(){
        let inputField = app.staticTexts["InputTextField"]
        
        app.buttons["Length2Button"].tap()
        
        app.buttons["Button1"].tap()
        app.buttons["Button2"].tap()
        //Delete one digit and check
        app.buttons["BackSpaceButton"].tap()
        XCTAssertEqual(inputField.label , "1")
    }
    
    func testLength2Button() {
        let resultLabel = app.staticTexts["ResultLabel"]
        let inputLabel = app.staticTexts["InputLabel"]
        
        app.buttons["Length2Button"].tap()
      
        XCTAssertEqual(resultLabel.label, "Inch")
        XCTAssertEqual(inputLabel.label, "cm")
    }
    
    func testWeightButton() {
        let resultLabel = app.staticTexts["ResultLabel"]
        let inputLabel = app.staticTexts["InputLabel"]
        
        app.buttons["WeightButton"].tap()
      
        XCTAssertEqual(resultLabel.label, "Lb")
        XCTAssertEqual(inputLabel.label, "Kg")
    }
    
    func testVolumeButton() {
        let resultLabel = app.staticTexts["ResultLabel"]
        let inputLabel = app.staticTexts["InputLabel"]
        
        app.buttons["VolumeButton"].tap()
      
        XCTAssertEqual(resultLabel.label, "Gallon")
        XCTAssertEqual(inputLabel.label, "Litre")
    }
    
    func testLengthButton() {
        let resultLabel = app.staticTexts["ResultLabel"]
        let inputLabel = app.staticTexts["InputLabel"]
        
        app.buttons["LengthButton"].tap()
      
        XCTAssertEqual(resultLabel.label, "Foot")
        XCTAssertEqual(inputLabel.label, "Metre")
    }
    
    func testTempButton() {
           let resultLabel = app.staticTexts["ResultLabel"]
           let inputLabel = app.staticTexts["InputLabel"]
           
           app.buttons["TempButton"].tap()
         
           XCTAssertEqual(resultLabel.label, "°F")
           XCTAssertEqual(inputLabel.label, "°C")
       }
       
    func testSpeedButton() {
           let resultLabel = app.staticTexts["ResultLabel"]
           let inputLabel = app.staticTexts["InputLabel"]
           
           app.buttons["SpeedButton"].tap()
         
           XCTAssertEqual(resultLabel.label, "Miles")
           XCTAssertEqual(inputLabel.label, "Km")
       }
    
}
