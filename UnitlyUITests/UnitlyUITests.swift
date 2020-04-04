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
        
        let topTextField = app.textFields["ViewController.topTextField"]
        topTextField.tap()
        topTextField.typeText("1")
        
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
        
        
        
        
    }
}
