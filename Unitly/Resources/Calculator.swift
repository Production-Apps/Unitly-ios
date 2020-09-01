//
//  Calculator.swift
//  Minimalist Unit Converter
//
//  Created by FGT MAC on 2/22/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation


enum OperationType: String {
    case distance = "1"
    case temperature = "2"
    case length = "3"
    case volume = "4"
    case weight = "5"
    case length2 = "6"
}

struct Calculator {
    
    //MARK: - Properties
    
    private var value : Double = 0.0
    private var type: OperationType = .distance
    
    //MARK: - Methods
    mutating func getResult(value: Double,for type: OperationType, isMetricEnable: Bool) -> Double {
        self.value = value
        self.type = type
       
          if isMetricEnable {
              return calculateMetricToImperial()
          }else{
              return calculateImperialToMetric()
          }
      }
    
    
    //MARK: - Private methods
    
    private func calculateImperialToMetric() -> Double {
        switch type {
        case .distance:
            return 1.609 * value
        case .temperature:
            return (value - 32) * 5/9
        case .length:
            return value * 0.3048
        case .volume:
            return  3.785 * value
        case .weight:
            return value * 0.45359237
        case .length2:
            return value * 2.54
        }
    }
    
    //Calculates the result from the given value in the botton textField to show on the top textField
    private func calculateMetricToImperial() -> Double {
        switch type {
        case .distance:
            return 0.621 * value
        case .temperature:
            return value * 9/5 + 32
        case .length:
            return value * 3.28084
        case .volume:
            return value * 0.2641
        case .weight:
            return value * 2.2046226218
        case .length2:
            return value / 2.54
        }
    }
    
}

