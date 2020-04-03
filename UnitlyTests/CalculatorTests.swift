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

    //Fahrenheit <-> Celsius
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
    
    //Foot <-> Metre
    func testLenght() {
        let cal = Calculator()
        
        //Result for Foot input and Metre output
        let metreResult = cal.calResult(type: "lenght", topValue: "1", bottonValue: "")
        //1F = -17.22F
        XCTAssertEqual(metreResult, "0.30")
        
        //Result for Metre input and Foot output
        let footResult = cal.calResult(type: "lenght", topValue: "", bottonValue: "1")
        //1F = -17.22F
        XCTAssertEqual(footResult, "3.28")
    }
    
    

}
