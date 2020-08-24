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
    switch type {
    case .distance:
        return 1.609 * topValue
    case .temperature:
        return (topValue - 32) * 5/9
    case .length:
        return topValue * 0.3048
    case .volume:
        return  3.785 * topValue
    case .weight:
        return topValue * 0.45359237
    case .length2:
        return topValue * 2.54
    }
}
    
    //Calculates the result from the given value in the botton textField to show on the top textField
    func calculateEquationForTopField(for type: OperationType,value bottonValue: Double ) -> Double {
    switch type {
    case .distance:
        return 0.621 * bottonValue
    case .temperature:
        return bottonValue * 9/5 + 32
    case .length:
        return bottonValue * 3.28084
    case .volume:
        return bottonValue * 0.2641
    case .weight:
        return bottonValue * 2.2046226218
    case .length2:
        return bottonValue / 2.54
    }
}
    
}

