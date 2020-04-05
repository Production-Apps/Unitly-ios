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
    @IBOutlet weak var distanceButton: UIBarButtonItem!
    @IBOutlet weak var temperatureButton: UIBarButtonItem!
    @IBOutlet weak var lengthButton: UIBarButtonItem!
    @IBOutlet weak var volumenButton: UIBarButtonItem!
    @IBOutlet weak var weightButton: UIBarButtonItem!
    @IBOutlet weak var length2Button: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottonTextField: UITextField!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottonLabel: UILabel!
    
    
    //MARK: - Properties
    var calculator = Calculator()
    var currentSelection: OperationType = .distance
    
    
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = self
        bottonTextField.delegate = self
        
        prepareToolBar()
        
        //Selected distanceButton as default when view loads
        setActiveButton(buttonSelected: distanceButton)
        
        prepareLabelRadius()
        
        prepareTextFields()
        
        addDoneButtonOnKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    

    
    //MARK: - IBActions
    
    //TODO: Refactor to use one IBAction for all buttons
    @IBAction func distanceButtonPressed(_ sender: UIBarButtonItem) {
        setActiveButton(buttonSelected: sender)
    }
    
    @IBAction func tempButtonPressed(_ sender: UIBarButtonItem) {
        setActiveButton(buttonSelected: sender)
    }
    
    @IBAction func lenghtButtonPressed(_ sender: UIBarButtonItem) {
        setActiveButton(buttonSelected: sender)
    }
    
    @IBAction func volumenButtonPressed(_ sender: UIBarButtonItem) {
        setActiveButton(buttonSelected: sender)
    }
    
    @IBAction func weightButtonPressed(_ sender: UIBarButtonItem) {
         setActiveButton(buttonSelected: sender)
    }
    @IBAction func lenght2ButtonPressed(_ sender: UIBarButtonItem) {
        setActiveButton(buttonSelected: sender)
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        clearTextField()
    }
    
    
    //MARK: - Setup UI
    
    
    //Cleanup keyboard events
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //Use to adjust view when keyboard appears
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            //Substract so as not to move the entire view
            let percent = keyboardRect.cgRectValue.height * 0.30
            view.frame.origin.y = -percent
        }else{
            view.frame.origin.y = 0
        }
    }
    
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
       
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
       
       var items = [UIBarButtonItem]()
       items.append(flexSpace)
       items.append(done)
       
       doneToolbar.items = items
       doneToolbar.sizeToFit()
       
       self.topTextField.inputAccessoryView = doneToolbar
        self.bottonTextField.inputAccessoryView = doneToolbar
       
     }
    
    func prepareToolBar() {
        
        distanceButton.image = UIImage.fontAwesomeIcon(name: .tachometerAlt , style: .solid, textColor: UIColor.blue, size: CGSize(width: 30, height: 30))
        
        temperatureButton.image = UIImage.fontAwesomeIcon(name: .thermometerHalf , style: .solid, textColor: UIColor.blue, size: CGSize(width: 30, height: 30))
        
        lengthButton.image = UIImage.fontAwesomeIcon(name: .ruler , style: .solid, textColor: UIColor.blue, size: CGSize(width: 30, height: 30))
        
        volumenButton.image = UIImage.fontAwesomeIcon(name: .tint , style: .solid, textColor: UIColor.blue, size: CGSize(width: 30, height: 30))
        
        weightButton.image = UIImage.fontAwesomeIcon(name: .balanceScaleRight , style: .solid, textColor: UIColor.blue, size: CGSize(width: 30, height: 30))
        
        length2Button.image = UIImage.fontAwesomeIcon(name: .rulerVertical , style: .solid, textColor: UIColor.blue, size: CGSize(width: 30, height: 30))
        
        clearButton.layer.cornerRadius = 10
    }
    
    func prepareLabelRadius(){
        
        topLabel.clipsToBounds = true
        topLabel.layer.cornerRadius = 5
        topLabel.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        topTextField.clipsToBounds = true
        topTextField.layer.cornerRadius = 5
        topTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        bottonTextField.clipsToBounds = true
        bottonTextField.layer.cornerRadius = 5
        bottonTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        bottonLabel.clipsToBounds = true
        bottonLabel.layer.cornerRadius = 5
        bottonLabel.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    func prepareTextFields() {
        //Add padding to the left of the textfield
        let tpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.topTextField.frame.height))
        topTextField.leftView = tpaddingView
        topTextField.leftViewMode = UITextField.ViewMode.always
        let bpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.bottonTextField.frame.height))
        bottonTextField.leftView = bpaddingView
        bottonTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    //FIXME: Issue with the first Lenth which is selecting distance instead
    //Set the selected toolbar button as active
    func setActiveButton(buttonSelected: UIBarButtonItem){
        guard let selectedButton = buttonSelected.title else { return }
    
        currentSelection(OperationType(rawValue: selectedButton) ?? .distance )
        
        //Array of button IBOutlets
        let buttonsArray = [distanceButton,temperatureButton,lengthButton, volumenButton, weightButton, length2Button ]
        
        //Change the color to blue if selected else to gray
        for button in buttonsArray{
            if button?.title == selectedButton{
                button?.tintColor = UIColor.systemBlue
            }else{
                button?.tintColor = UIColor.systemGray
            }
        }
    }
    
    //Change the Label base on current selection
    func currentSelection(_ selectedButton: OperationType)  {
        
        //Clear textField every time user change selection
        clearTextField()
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
        case .lenght2:
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
    func clearTextField() {
        topTextField.placeholder =  ""
        topTextField.text = ""
        bottonTextField.text = ""
        bottonTextField.placeholder =  ""
    }
    
    
    //MARK: - Actions
    
    func getResult() {
        guard let top = topTextField.text else { return }
        guard let botton = bottonTextField.text else { return }
        
        //Check if the field is empty then invoke the method to get the result to show result on the oppositive field
        if top.isEmpty{
            //check if the string can be converted to a double
            if botton.double != nil {
                topTextField.text = calculator.calResult(type: currentSelection, topValue: "", bottonValue: botton)
            }
            
        }else if botton.isEmpty{
            //check if the string can be converted to a double
            if top.double != nil{
                bottonTextField.text = calculator.calResult(type: currentSelection, topValue: top, bottonValue: "")
            }
            
        }
    }
    
    @objc func doneButtonAction(){
        topTextField.endEditing(true)
        bottonTextField.endEditing(true)
        getResult()
    }
    
    
}


//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //Clear fields when the user try to enter a new value to start over
        clearTextField()
        
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

