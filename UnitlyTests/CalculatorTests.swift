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
        
        //Farenheit input To Celsius output
        let celsiusResult = cal.calResult(type: "temp", topValue: "1", bottonValue: "")
        //1F = -17.22C
        XCTAssertEqual(celsiusResult, "-17.22")
        
        //Celsius input To Farenheit output
        let fahrenheitResult = cal.calResult(type: "temp", topValue: "", bottonValue: "1")
        //1C = 33.80F
        XCTAssertEqual(fahrenheitResult, "33.80")
    }
    
    //Foot <-> Metre
    func testLenght() {
        let cal = Calculator()
        
        //Foot input To Metre output
        let metreResult = cal.calResult(type: "lenght", topValue: "1", bottonValue: "")
        //1F = 0.30M
        XCTAssertEqual(metreResult, "0.30")
        
        //Metre input To Foot output
        let footResult = cal.calResult(type: "lenght", topValue: "", bottonValue: "1")
        //1M = 3.28F
        XCTAssertEqual(footResult, "3.28")
    }
    
    //Gallon <-> Litre
    func testVolume() {
        let cal = Calculator()
        
        //Gallon input To Litre output
        let litreResult = cal.calResult(type: "volume", topValue: "1", bottonValue: "")
        //1G = 3.79L
        XCTAssertEqual(litreResult, "3.79")
        
        //Litre input To Gallon output
        let gallonResult = cal.calResult(type: "volume", topValue: "", bottonValue: "1")
        //1L = 0.26G
        XCTAssertEqual(gallonResult, "0.26")
    }
    
    

}
