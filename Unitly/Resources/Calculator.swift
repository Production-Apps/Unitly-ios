//
//  Calculator.swift
//  Minimalist Unit Converter
//
//  Created by FGT MAC on 2/22/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation


enum OperationType: String {
    case distance
    case temperature
    case length
    case volume
    case weight
    case lenght2
}

struct Calculator {

    func calResult(type: OperationType, topValue: String = "", bottonValue: String = "") -> String {
        
        
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
    private func topEquation(for type: OperationType,value topValue:String ) -> Double{
        
        guard let num = Double(topValue) else {return 0}
        
        switch type {
        case .distance:
            return 1.609 * num
        case .temperature:
            return (num - 32) * 5/9
        case .length:
            return num * 0.3048
        case .volume:
            return  3.785 * num
        case .weight:
            return num * 0.45359237
        case .lenght2:
            return num * 2.54
        }
    }
    
    
    //Calculates the result from the given value in the botton textField to show on the top textField
    private func bottonEquation(for type: OperationType,value bottonValue:String ) -> Double{
    
        guard let num = Double(bottonValue) else {return 0}
        
        switch type {
        case .distance:
            return 0.621 * num
        case .temperature:
            return num * 9/5 + 32
        case .length:
            return num * 3.28084
        case .volume:
            return num * 0.2641
        case .weight:
            return num * 2.2046226218
        case .lenght2:
            return num / 2.54
        }
    }
    
    
}

