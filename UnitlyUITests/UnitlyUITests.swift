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
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        app.toolbars.matching(identifier: "Toolbar").buttons["Done"].tap()
        
        
//        let app = XCUIApplication()
//
//        let topField = app.textFields["Top Text Field"]
//        topField.tap()
//        topField.typeText("1")
//
//
//        let doneButton = app.toolbars.matching(identifier: "Toolbar").buttons["Done"]
//        doneButton.tap()

    }
}
