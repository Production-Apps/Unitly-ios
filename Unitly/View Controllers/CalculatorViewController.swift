//
//  ViewController.swift
//  Minimalist Unit Converter
//
//  Created by FGT MAC on 2/21/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit
import FontAwesome_swift

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
    private var viewModel = CalculatorViewModel()
    
    private var isMenuExtended: Bool = false
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareToolBar()
        viewModel.delegate = self
        inputValueLabel.text = viewModel.inputValue
        resultValueLabel.text = viewModel.resultValue
        
        //Selected distanceButton as default when view loads
        setActiveButton(distanceButton)
    }
    
    //MARK: - IBActions
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if let numVal = sender.titleLabel, let value = numVal.text {
            print(value)
            viewModel.processInput(for: value)
        }
    }
    
    @IBAction func calcTypeButtonPressed(_ sender: UIButton) {
        setActiveButton(sender)
       }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        viewModel.deleteLastNum()
    }
    
    @IBAction func clearFields(_ sender: UIButton) {
        viewModel.clearValueField()
    }
    
    @IBAction func switchFormulaButtonPressed(_ sender: UIButton) {
        viewModel.isMetricEnable.toggle()
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
        let alert = UIAlertController(title: viewModel.alertTitle, message: viewModel.alertMessage, preferredStyle: .actionSheet)
        
        let positiveFeedback = UIAlertAction(title: viewModel.positiveActionTitle, style: .default) { (_) in
            guard let url = URL(string: self.viewModel.positiveActionURL) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            self.animateMenu()//Close menu
        }
        
        let negativeFeedback = UIAlertAction(title: viewModel.negativeActionTitle, style: .default) { (_) in
            guard let url = URL(string: self.viewModel.negativeActionURL) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            self.animateMenu()//Close menu
        }
        
        let cancel = UIAlertAction(title: viewModel.cancelActionTitle, style: .cancel)
        
        alert.addAction(positiveFeedback)
        alert.addAction(negativeFeedback)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setActiveButton(_ selectedButton: UIButton){
        //Array of button IBOutlets
        let buttonsArray = [distanceButton,temperatureButton,lengthButton, volumenButton, weightButton, length2Button ]
        
        let tag  = selectedButton.tag
        
        viewModel.currentSelection = OperationType.init(rawValue: String(tag))!
        
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
        viewModel.clearValueField()
        
        let title = viewModel.getTitleType()
        
        resultTypeLabel.text = title.resultLabel
        inputTypeLabel.text = title.inputLabel
    }
}

    //MARK: - CalculatorDelegate
extension CalculatorViewController: CalculatorDelegate{
    func resultDidChanged() {
        inputValueLabel.text = viewModel.inputValue
        resultValueLabel.text = viewModel.resultValue
    }
}
