//
//  Calculator.swift
//  Minimalist Unit Converter
//
//  Created by FGT MAC on 2/22/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation

struct Calculator {

    func calResult(type: String, topValue: String = "", bottonValue: String = "") -> String {
        
        
        var finalValue = 00.00
        
        if !topValue.isEmpty{
            finalValue = topEquation(for: type, value: topValue)
        }else if !bottonValue.isEmpty{
            finalValue = bottonEquation(for: type, value: bottonValue)
        }
        //Return final value as String
        return String(format:"%.2f", finalValue)
    }
    
    
    //Calculates the result from the given value in the top textField to show on the botton textField
    func topEquation(for type: String,value topValue:String ) -> Double{
        
        var tempValue = 00.00
        let num = Double(topValue)
        
        switch type {
        case "temp":
            tempValue = (num! - 32) * 5/9
        case "lenght":
            tempValue = num! * 0.3048
        case "volumen":
            tempValue =  3.78541 * num!
        case "weight":
            tempValue = num! * 0.45359237
        case "lenght2":
            tempValue = num! * 2.54
        default:
            tempValue = 1.609 * num!
        }
        return tempValue
    }
    
    
    //Calculates the result from the given value in the botton textField to show on the top textField
    func bottonEquation(for type: String,value bottonValue:String ) -> Double{
        
        
        var tempValue = 00.00
        let num = Double(bottonValue)
        
        switch type {
        case "temp":
            tempValue = num! * 9/5 + 32
        case "lenght":
            tempValue = num! * 3.28084
        case "volumen":
            tempValue = num! * 0.2641
        case "weight":
            tempValue = num! * 2.2046226218
        case "lenght2":
            tempValue = num! / 2.54
        default:
            tempValue = 0.621 * num!
        }
        return tempValue
    }
    
    
}
