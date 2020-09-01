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
    var calBrain = Calculator()
    
    //Fahrenheit <-> Celsius
    func testTemperature() {
        
        //Farenheit input To Celsius output
        let farenheitTocelsiusResult = calBrain.getResult(value: 1, for: .temperature, isMetricEnable: false)
        
        //1F = -17.22C
        XCTAssertEqual(String(format: "%.2f", farenheitTocelsiusResult), "-17.22")
        
        //Celsius input To Farenheit output
        let celsiusToFarenheitResult = calBrain.getResult(value: 1, for: .temperature, isMetricEnable: true)
        //1C = 33.80F 
        XCTAssertEqual(String(format: "%.2f", celsiusToFarenheitResult), "33.80")
    }
    
    //Foot <-> Metre
    func testLenght() {
        
        //Foot input To Metre output
        let footToMetreResult = calBrain.getResult(value: 1, for: .length, isMetricEnable: false)
        //1F = 0.30M
        XCTAssertEqual(String(format: "%.2f", footToMetreResult), "0.30")
        
        //Metre input To Foot output
        let MetreToFootResult = calBrain.getResult(value: 1, for: .length, isMetricEnable: true)
        //1M = 3.28F
        XCTAssertEqual(String(format: "%.2f", MetreToFootResult), "3.28")
    }
    
    //Gallon <-> Litre
    func testVolume() {
        
        //Gallon input To Litre output
        let gallonTolitreResult = calBrain.getResult(value: 1, for: .volume, isMetricEnable: false)
        //1G = 3.79L
        XCTAssertEqual(String(format: "%.2f", gallonTolitreResult), "3.79")
        
        //Litre input To Gallon output
        let litreToBallonResult = calBrain.getResult(value: 1, for: .volume, isMetricEnable: true)
        //1L = 0.26G
        XCTAssertEqual(String(format: "%.2f", litreToBallonResult), "0.26")
    }
    
    //Lb <-> Kg
    func testWeight() {
        
        //Pounds input To Kilograms output
        let poundToKilogramsResult = calBrain.getResult(value: 1, for: .weight, isMetricEnable: false)
        //1G = 3.79L
        XCTAssertEqual(String(format: "%.2f", poundToKilogramsResult), "0.45")
        
        //Kilograms input To Pounds output
        let poundsTopoundResult = calBrain.getResult(value: 1, for: .weight, isMetricEnable: true)
        //1L = 0.26G
        XCTAssertEqual(String(format: "%.2f", poundsTopoundResult), "2.20")
    }
    
    
    //Inches <-> Cemtimeters
    func testLenght2() {
        
        //Inches input To Cemtimeters output
        let inchToCemtimetersResult = calBrain.getResult(value: 1, for: .length2, isMetricEnable: false)
        //1G = 3.79L
        XCTAssertEqual(String(format: "%.2f", inchToCemtimetersResult), "2.54")
        
        //Cemtimeters input To Inches output
        let cemtimetersToinchResult = calBrain.getResult(value: 1, for: .length2, isMetricEnable: true)
        //1L = 0.26G
        XCTAssertEqual(String(format: "%.2f", cemtimetersToinchResult), "0.39")
    }
    
    
    //Miles <-> Kilometers
    func testDistance() {
        
        //Miles input To Kilometers output
        let milesToKilometersResult = calBrain.getResult(value: 1, for: .distance, isMetricEnable: false)
        //1G = 3.79L
        XCTAssertEqual(String(format: "%.2f", milesToKilometersResult), "1.61")
        
        //Kilometers input To Miles output
        let kilometerToMilesResult = calBrain.getResult(value: 1, for: .distance, isMetricEnable: true)
        //1L = 0.26G
        XCTAssertEqual(String(format: "%.2f", kilometerToMilesResult), "0.62")
    }

}
