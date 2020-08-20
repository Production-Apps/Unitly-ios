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
    case length2
}

struct Calculator {
    
    
    //Calculates the result from the given value in the top textField to show on the botton textField
    func calculateEquationForBottomField(for type: OperationType,value topValue: Double ) -> Double {
    
        var finalValue: Double?
        
    switch type {
    case .distance:
        finalValue = 1.609 * topValue
    case .temperature:
        finalValue = (topValue - 32) * 5/9
    case .length:
        finalValue = topValue * 0.3048
    case .volume:
        finalValue =  3.785 * topValue
    case .weight:
        finalValue = topValue * 0.45359237
    case .length2:
        finalValue = topValue * 2.54
    }
        return finalValue ?? 0.0
}
    
    //Calculates the result from the given value in the botton textField to show on the top textField
    func calculateEquationForTopField(for type: OperationType,value bottonValue: Double ) -> Double {
        
    var finalValue: Double?
        
    switch type {
    case .distance:
        finalValue = 0.621 * bottonValue
    case .temperature:
        finalValue = bottonValue * 9/5 + 32
    case .length:
        finalValue = bottonValue * 3.28084
    case .volume:
        finalValue = bottonValue * 0.2641
    case .weight:
        finalValue = bottonValue * 2.2046226218
    case .length2:
        finalValue = bottonValue / 2.54
    }
        return finalValue ?? 0.0
}
    
}

