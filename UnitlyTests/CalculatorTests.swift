//
//  CalculatorTests.swift
//  UnitlyTests
//
//  Created by FGT MAC on 4/3/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import XCTest
@testable import Unitly


class CalculatorTests: XCTestCase {

    func testTemp() {
        
        let cal = Calculator()
        
        //Result of entering Fahrenheit and geting Celsius
        let celsiusResult = cal.calResult(type: "temp", topValue: "1", bottonValue: "")
        //1F = -17.22F
        XCTAssertEqual(celsiusResult, "-17.22")
        
        //Result of entering Farenheit and geting Celsius
        let fahrenheitResult = cal.calResult(type: "temp", topValue: "", bottonValue: "1")
        //1F = -17.22F
        XCTAssertEqual(fahrenheitResult, "33.80")
    }

}
