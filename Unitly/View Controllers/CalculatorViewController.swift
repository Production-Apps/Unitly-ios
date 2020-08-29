//
//  ViewController.swift
//  Minimalist Unit Converter
//
//  Created by FGT MAC on 2/21/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit
import FontAwesome_swift
import MessageUI

class CalculatorViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var lengthButton: UIButton!
    @IBOutlet weak var volumenButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var length2Button: UIButton!
    
    @IBOutlet weak var resultValueLabel: UILabel!
    @IBOutlet weak var inputValueLabel: UILabel!
    
    @IBOutlet weak var resultTypeLabel: UILabel!
    @IBOutlet weak var inputTypeLabel: UILabel!
    
    @IBOutlet weak var trailingCalcView: NSLayoutConstraint!
    @IBOutlet weak var lealingCalcView: NSLayoutConstraint!
    
    @IBOutlet weak var burgerMenu: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    

    //MARK: - Properties
    private var calculator = Calculator()
    private var isMenuExtended: Bool = false
    private var currentSelection: OperationType = .distance
    private var resultDisplayValue: Double {
        get{
            guard let dVal = Double(resultValueLabel.text!) else { return 0.0 }
            return dVal
        }
        
        set{
            resultValueLabel.text = newValue.withCommas()
        }
    }
    private var inputDisplayValue: Double {
        get{
            
            let cleanVal = inputValueLabel.text!.replacingOccurrences(of: ",", with: "")
            
            guard let dVal = Double(cleanVal) else { return 0.0 }
            
            return dVal
        }
        
        set{
            inputValueLabel.text = newValue.withCommas()
        }
    }
    private var isMetricEnable: Bool = true
    private var isFinishTyping: Bool = true
    private var tempInputValue: String = ""
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareToolBar()
        
        //Selected distanceButton as default when view loads
        setActiveButton(distanceButton)
    }
    
    //MARK: - IBActions
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if let numVal = sender.titleLabel, let value = numVal.text {
            processInput(for: value)
        }
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
    
    //Menu section -- Menu View is hidden behind CalcView it can be drag under to edit
    @IBAction func toggleMenu(_ sender: UIButton) {
        animateMenu()
    }
    
    @IBAction func feedbackButtonPressed(_ sender: UIButton) {
        showFeedbackAlert()
    }
    
    @IBAction func aboutUsButtonPressed(_ sender: UIButton) {
        //Direct to website
        guard let url = URL(string: "https://fritzgt.com") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        animateMenu()//Close menu
    }
    
    //MARK: - Setup UI
    private func prepareToolBar() {
        
        swapButton.layer.cornerRadius = 21
        swapButton.imageView?.contentMode = .scaleAspectFit
        
        swapButton.imageEdgeInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        
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
    
    private func animateMenu() {
        if !isMenuExtended {
            burgerMenu.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
            lealingCalcView.constant = 200
            trailingCalcView.constant = 200
            isMenuExtended = true
        }else{
            burgerMenu.setBackgroundImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
            lealingCalcView.constant = 0
            trailingCalcView.constant = 0
            isMenuExtended = false
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func showFeedbackAlert() {
        //show popup to present +/- choice then redirect to email for negative or to appstore feedback for positive
        let alert = UIAlertController(title: "Feedback", message: "Please choose type of feedback below:", preferredStyle: .actionSheet)
        
        let positiveFeedback = UIAlertAction(title: "👍 Love it!", style: .default) { (_) in
            guard let url = URL(string: "https://apps.apple.com/app/id1501719971?action=write-review") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            self.animateMenu()//Close menu
        }
        
        let negativeFeedback = UIAlertAction(title: "👎 Problems?", style: .default) { (_) in
            guard let url = URL(string: "mailto:contact@fritzgt.com") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            self.animateMenu()//Close menu
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(positiveFeedback)
        alert.addAction(negativeFeedback)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
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
    
    //Change the Labels base on current selection
    private func setLabelName()  {
        clearValueField()
        //Change placeholder
        switch currentSelection {
        case .temperature:
            resultTypeLabel.text = isMetricEnable ? "°F" : "°C"
            inputTypeLabel.text = isMetricEnable ? "°C" : "°F"
        case .length :
            resultTypeLabel.text = isMetricEnable ? "Foot" : "Metre"
            inputTypeLabel.text = isMetricEnable ? "Metre" :  "Foot"
        case .length2:
            resultTypeLabel.text = isMetricEnable ? "Inch" : "cm"
            inputTypeLabel.text = isMetricEnable ? "cm" : "Inch"
        case .volume :
            resultTypeLabel.text = isMetricEnable ? "Gallon" : "Litre"
            inputTypeLabel.text = isMetricEnable ? "Litre" : "Gallon"
        case .weight :
            resultTypeLabel.text = isMetricEnable ? "Lb" : "Kg"
            inputTypeLabel.text = isMetricEnable ? "Kg" : "Lb"
        default:
            resultTypeLabel.text = isMetricEnable ? "Miles" : "Km"
            inputTypeLabel.text = isMetricEnable ? "Km" : "Miles"
        }
    }
    
    //MARK: - General private Methods
    
    //Clear fields
    private func deleteLastNum() {
        let _ = inputValueLabel.text?.popLast()
        tempInputValue = inputValueLabel.text!.replacingOccurrences(of: ",", with: "")
        if inputValueLabel.text == "" {
            inputValueLabel.text = "0"
            isFinishTyping = true
        }

         getResult()
    }
    
    private func clearValueField() {
        inputValueLabel.text = "0"
        resultValueLabel.text = "0"
        isFinishTyping = true
    }
    
    private func processInput(for value: String) {
        
        //guard let totalVal = inputValueLabel.text else { return }
        
        let maxCharReached = inputValueLabel.text!.count >= 11
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
            resultDisplayValue = calculator.calculateMetricToImperial(for: currentSelection, value: inputDisplayValue)
        }else{
            resultDisplayValue = calculator.calculateImperialToMetric(for: currentSelection, value: inputDisplayValue)
        }
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
