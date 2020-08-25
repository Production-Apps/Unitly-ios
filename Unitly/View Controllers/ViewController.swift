//
//  ViewController.swift
//  Minimalist Unit Converter
//
//  Created by FGT MAC on 2/21/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit
import FontAwesome_swift


class ViewController: UIViewController {
    

    
    //MARK: - Outlets
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var lengthButton: UIButton!
    @IBOutlet weak var volumenButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var length2Button: UIButton!
    //@IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var topValueLabel: UILabel!
    @IBOutlet weak var bottomValueLabel: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottonLabel: UILabel!
    
    
    //MARK: - Properties
    private var calculator = Calculator()
    
    private var currentSelection: OperationType = .distance
    
    private var topDisplayValue: Double {
        get{
            guard let dVal = Double(topValueLabel.text!) else { return 0.0 }
            return dVal
        }
        
        set{
            topValueLabel.text = String(format: "%.2f", newValue)
        }
    }
    
    private var bottomDisplayValue: Double {
        get{
            guard let dVal = Double(bottomValueLabel.text!) else { return 0.0 }
            return dVal
        }
        
        set{
            bottomValueLabel.text = String(format: "%.2f", newValue)
        }
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareToolBar()
     
        //Selected distanceButton as default when view loads
        setActiveButton(distanceButton)
        
    }
    
    //MARK: - IBActions
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if bottomValueLabel.text == "0"{
            bottomValueLabel.text = ""
            bottomValueLabel.text! += (sender.titleLabel?.text)!
        }else{
            bottomValueLabel.text! += (sender.titleLabel?.text)!
        }
        
    }
    
    @IBAction func calcTypeButtonPressed(_ sender: UIButton) {
        setActiveButton(sender)
       }
    
    @IBAction func clearButton(_ sender: UIButton) {
        deleteLastNum()
    }
    
    
    //MARK: - Setup UI
    
    private func prepareToolBar() {
       
        let distImg = UIImage.fontAwesomeIcon(name: .tachometerAlt , style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        distanceButton.setImage( distImg, for: .normal)
        
        let tempImg = UIImage.fontAwesomeIcon(name: .thermometerHalf , style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        temperatureButton.setImage(tempImg, for: .normal)
        
        let  lengthImg = UIImage.fontAwesomeIcon(name: .ruler , style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        lengthButton.setImage(lengthImg, for: .normal)
        
        let volumenImg = UIImage.fontAwesomeIcon(name: .tint , style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        volumenButton.setImage(volumenImg, for: .normal)
        
        let weightImg = UIImage.fontAwesomeIcon(name: .balanceScaleRight , style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        weightButton.setImage(weightImg, for: .normal)
        
        let length2Img = UIImage.fontAwesomeIcon(name: .rulerVertical , style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        length2Button.setImage(length2Img, for: .normal)
    }
    
    private func setActiveButton(_ selectedButton: UIButton){
        //Array of button IBOutlets
        let buttonsArray = [distanceButton,temperatureButton,lengthButton, volumenButton, weightButton, length2Button ]
        
        let tag  = selectedButton.tag
        
        currentSelection(OperationType.init(rawValue: String(tag)) ?? .distance)
        
        //Change the color to blue if selected else to gray
        for button in buttonsArray{
            if button?.tag == tag {
                button?.tintColor = UIColor.systemBlue
            }else{
                button?.tintColor = UIColor.white
            }
        }
    }
    
    //Change the Label base on current selection
    private func currentSelection(_ selectedButton: OperationType)  {
        
        //Clear textField every time user change selection
        clearValueField()
        //set the currently selected button to also use it in textFieldDidEndEditing
        currentSelection = selectedButton
        //Change placeholder
        switch selectedButton {
        case .temperature:
            topLabel.text = "°F"
            bottonLabel.text = "°C"
        case .length :
            topLabel.text = "Foot"
            bottonLabel.text = "Metre"
        case .length2:
            topLabel.text = "Inch"
            bottonLabel.text = "CM"
        case .volume :
            topLabel.text = "Gallon"
            bottonLabel.text = "Litre"
        case .weight :
            topLabel.text = "Lb"
            bottonLabel.text = "Kg"
        default:
            topLabel.text = "Miles"
            bottonLabel.text = "KM"
            
        }
    }
    
    //Clear fields
    private func deleteLastNum() {
        let _ = bottomValueLabel.text?.popLast()
        if bottomValueLabel.text == "" {
            bottomValueLabel.text = "0"
        }
    }
    
    private func clearValueField() {
        bottomValueLabel.text = "0"
        topValueLabel.text = "0"
    }
    
    
    //MARK: - General private methods
    
    private func getResult() {
        //Check if the field is empty then invoke the method to get the result to show result on the oppositive field
        if topDisplayValue == 0{
            topDisplayValue = calculator.calculateEquationForTopField(for: currentSelection, value: bottomDisplayValue)
            
        }else if bottomDisplayValue == 0 {
            bottomDisplayValue = calculator.calculateEquationForBottomField(for: currentSelection, value: topDisplayValue)
        }
    }
    
    @objc func doneButtonAction(){
        topValueLabel.endEditing(true)
        bottomValueLabel.endEditing(true)
        getResult()
    }
    
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //Clear fields when the user try to enter a new value to start over
        deleteLastNum()
        
        return true
    }
    
    //In case an ipad user press return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Dismiss keyboard after user click return
        doneButtonAction()
        return true
    }

    //Prevent user from adding more than one decimal point and 2 decimal places
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if let value = textField.text  {
             // Allow to remove character (Backspace)
             if string == "" {
                 return true
             }

              //Prevent user from adding more than one decimal point
             if value.contains(".") && string == "."{
                 return false
             }
              //Prevent user from adding more than 2 decimal places
             if value.contains("."){
                 let limitDecimalPlace = 2
                 let decimalPlace = value.components(separatedBy: ".").last
                 if decimalPlace!.count < limitDecimalPlace {
                     return true
                 }else{
                     return false
                 }
             }
         }
         return true
     }
    
}

//MARK: - StringProtocol

//Use to check if String is a valid double in case use enter a letter in the textField it return nil
extension StringProtocol {
    var double: Double? {Double(self)}
}

