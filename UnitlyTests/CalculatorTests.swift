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
    func testTemperature() {
        let cal = Calculator()
        
        //Farenheit input To Celsius output
        let celsiusResult = cal.calResult(type: .temperature, topValue: "1", bottonValue: "")
        //1F = -17.22C
        XCTAssertEqual(celsiusResult, "-17.22")
        
        //Celsius input To Farenheit output
        let fahrenheitResult = cal.calResult(type: .temperature, topValue: "", bottonValue: "1")
        //1C = 33.80F
        XCTAssertEqual(fahrenheitResult, "33.80")
    }
    
    //Foot <-> Metre
    func testLenght() {
        let cal = Calculator()
        
        //Foot input To Metre output
        let metreResult = cal.calResult(type: .length, topValue: "1", bottonValue: "")
        //1F = 0.30M
        XCTAssertEqual(metreResult, "0.30")
        
        //Metre input To Foot output
        let footResult = cal.calResult(type: .length, topValue: "", bottonValue: "1")
        //1M = 3.28F
        XCTAssertEqual(footResult, "3.28")
    }
    
    //Gallon <-> Litre
    func testVolume() {
        let cal = Calculator()
        
        //Gallon input To Litre output
        let litreResult = cal.calResult(type: .volume, topValue: "1", bottonValue: "")
        //1G = 3.79L
        XCTAssertEqual(litreResult, "3.79")
        
        //Litre input To Gallon output
        let gallonResult = cal.calResult(type: .volume, topValue: "", bottonValue: "1")
        //1L = 0.26G
        XCTAssertEqual(gallonResult, "0.26")
    }
    
    //Lb <-> Kg
    func testWeight() {
        let cal = Calculator()
        
        //Pounds input To Kilograms output
        let kilogramsResult = cal.calResult(type: .weight, topValue: "1", bottonValue: "")
        //1G = 3.79L
        XCTAssertEqual(kilogramsResult, "0.45")
        
        //Kilograms input To Pounds output
        let poundsResult = cal.calResult(type: .weight, topValue: "", bottonValue: "1")
        //1L = 0.26G
        XCTAssertEqual(poundsResult, "2.20")
    }
    
    
    //Inches <-> Cemtimeters
    func testLenght2() {
        let cal = Calculator()
        
        //Inches input To Cemtimeters output
        let cemtimetersResult = cal.calResult(type: .lenght2, topValue: "1", bottonValue: "")
        //1G = 3.79L
        XCTAssertEqual(cemtimetersResult, "2.54")
        
        //Cemtimeters input To Inches output
        let inchesResult = cal.calResult(type: .lenght2, topValue: "", bottonValue: "1")
        //1L = 0.26G
        XCTAssertEqual(inchesResult, "0.39")
    }
    
    
    //Miles <-> Kilometers
    func testDistance() {
        let cal = Calculator()
        
        //Miles input To Kilometers output
        let kilometersResult = cal.calResult(type: .distance, topValue: "1", bottonValue: "")
        //1G = 3.79L
        XCTAssertEqual(kilometersResult, "1.61")
        
        //Kilometers input To Miles output
        let milesResult = cal.calResult(type: .distance, topValue: "", bottonValue: "1")
        //1L = 0.26G
        XCTAssertEqual(milesResult, "0.62")
    }

}
