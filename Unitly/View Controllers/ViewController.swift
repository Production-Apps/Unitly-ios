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
    
    @IBOutlet weak var switchFormulaButton: UIButton!
    
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
    
    private var isMetricEnable: Bool = true
    
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
        getResult()
    }
    
    @IBAction func calcTypeButtonPressed(_ sender: UIButton) {
        setActiveButton(sender)
       }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        deleteLastNum()
    }
    
    @IBAction func clearFields(_ sender: UIButton) {
        clearValueField()
    }
    
    @IBAction func switchFormulaButtonPressed(_ sender: UIButton) {
        isMetricEnable.toggle()
        setLabelName()
    }
    
    
    //MARK: - Setup UI
    
    private func prepareToolBar() {
        
        switchFormulaButton.layer.cornerRadius = 10
       
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
        
        currentSelection = OperationType.init(rawValue: String(tag))!
        
        setLabelName()
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
    private func setLabelName()  {
        
        //Clear textField every time user change selection
        clearValueField()

        //Change placeholder
        switch currentSelection {
        case .temperature:
            topLabel.text = isMetricEnable ? "°F" : "°C"
            bottonLabel.text = isMetricEnable ? "°C" : "°F"
        case .length :
            topLabel.text = isMetricEnable ? "Foot" : "Metre"
            bottonLabel.text = isMetricEnable ? "Metre" :  "Foot"
        case .length2:
            topLabel.text = isMetricEnable ? "Inch" : "cm"
            bottonLabel.text = isMetricEnable ? "cm" : "Inch"
        case .volume :
            topLabel.text = isMetricEnable ? "Gallon" : "Litre"
            bottonLabel.text = isMetricEnable ? "Litre" : "Gallon"
        case .weight :
            topLabel.text = isMetricEnable ? "Lb" : "Kg"
            bottonLabel.text = isMetricEnable ? "Kg" : "Lb"
        default:
            topLabel.text = isMetricEnable ? "Miles" : "Km"
            bottonLabel.text = isMetricEnable ? "Km" : "Miles"
        }
    }
    
    //Clear fields
    private func deleteLastNum() {
        let _ = bottomValueLabel.text?.popLast()
        if bottomValueLabel.text == "" {
            bottomValueLabel.text = "0"
        }
         getResult()
    }
    
    private func clearValueField() {
        bottomValueLabel.text = "0"
        topValueLabel.text = "0"
    }
    
    
    //MARK: - General private methods
    
    private func getResult() {
        //Check if the field is empty then invoke the method to get the result to show result on the oppositive field
        if isMetricEnable {
            topDisplayValue = calculator.calculateMetricToImperial(for: currentSelection, value: bottomDisplayValue)
        }else{
            topDisplayValue = calculator.calculateImperialToMetric(for: currentSelection, value: bottomDisplayValue)
        }
    }
    
}

//MARK: - StringProtocol

//Use to check if String is a valid double in case use enter a letter in the textField it return nil
extension StringProtocol {
    var double: Double? {Double(self)}
}

