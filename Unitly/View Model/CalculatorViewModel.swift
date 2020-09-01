//
//  CalculatorViewModel.swift
//  Unitly
//
//  Created by FGT MAC on 8/31/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation

protocol CalculatorDelegate {
    func resultDidChanged()
}

class CalculatorViewModel {
    
    //MARK: - Properties
    private var calculatorBrain = Calculator()
    private var tempInputValue: String = ""
    private var resultDisplayValue: Double {
        get{
            guard let dVal = Double(resultValue) else { return 0.0 }
            return dVal
        }
        
        set{
            resultValue = newValue.withCommas()
        }
    }
    private var inputDisplayValue: Double {
        get{
            
            let cleanVal = inputValue.replacingOccurrences(of: ",", with: "")
            
            guard let dVal = Double(cleanVal) else { return 0.0 }
            
            return dVal
        }
        
        set{
            inputValue = newValue.withCommas()
        }
    }
    
    var currentSelection: OperationType = .distance
    
    var delegate: CalculatorDelegate?
    
    var inputValue: String = "0"
    var resultValue: String = "0"
    
    var isMetricEnable: Bool = true
    var isFinishTyping: Bool = true
    
    var alertTitle = "Feedback"
    var alertMessage = "Please choose type of feedback below:"
    
    var positiveActionTitle = "👍 Love it!"
    var positiveActionURL = "https://apps.apple.com/app/id1501719971?action=write-review"
    
    var negativeActionTitle = "👎 Problems?"
    var negativeActionURL = "mailto:contact@fritzgt.com"
    
    var cancelActionTitle = "Cancel"
    
    //MARK: - Methods
    
    //Sets the title for when a new measurement type is selected or switch
    func getTitleType() -> (resultLabel: String, inputLabel: String) {
        switch currentSelection {
        case .temperature:
            return isMetricEnable ? ("°F","°C") : ("°C","°F")
        case .length :
            return isMetricEnable ? ("Foot","Metre") : ("Metre","Foot")
        case .length2:
            return isMetricEnable ? ("Inch","cm") : ("cm","Inch")
        case .volume :
            return isMetricEnable ? ("Gallon","Litre") : ( "Litre","Gallon")
        case .weight :
            return isMetricEnable ? ("Lb","Kg") : ("Kg","Lb")
        default:
            return isMetricEnable ? ("Miles","Km") : ("Km","Miles")
        }
    }
    
    func deleteLastNum() {
        let _ = inputValue.popLast()
        //Set the tempInputValue so it matches the currently display value
        tempInputValue = inputValue.replacingOccurrences(of: ",", with: "")
        if inputValue == "" {
            inputValue = "0"
            isFinishTyping = true
        }
        
        getResult()
    }
    
    func clearValueField() {
        inputValue = "0"
        resultValue = "0"
        isFinishTyping = true
        
        getResult()
    }
    
    func processInput(for value: String){
        
        //guard let totalVal = inputValueLabel.text else { return }
        
        let maxCharReached = tempInputValue.count >= 11
        let containsDecimal = tempInputValue.contains(".")
        
        //Append and sanitze value to prevent multiple decimal points
        if isFinishTyping {
            tempInputValue = value
            isFinishTyping = false
        }else{
            numberFormatter.alwaysShowsDecimalSeparator = false
            if value == "."{
                //Setup here to prevent issue where display it wont show dot till the next digit is type
                numberFormatter.alwaysShowsDecimalSeparator = true
                if containsDecimal {
                    return //Return to preven adding another decimal point
                }
            }
            
            if maxCharReached {
                return
            }
            //Append if above conditions pass
            tempInputValue += value
        }
        if let doubleValue = Double(tempInputValue) {
            inputDisplayValue = doubleValue
            getResult()
        }
    }
    
    private func getResult() {
        //Check if the field is empty then invoke the method to get the result to show result on the oppositive field
        if isMetricEnable {
            resultDisplayValue = calculatorBrain.calculateMetricToImperial(for: currentSelection, value: inputDisplayValue)
        }else{
            resultDisplayValue = calculatorBrain.calculateImperialToMetric(for: currentSelection, value: inputDisplayValue)
        }
        delegate?.resultDidChanged()
        
    }
    
}

//MARK: - Double extension

//Use here to enable alwaysShowsDecimalSeparator inside processInput
let numberFormatter = NumberFormatter()

extension Double {
    func withCommas() -> String {
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
