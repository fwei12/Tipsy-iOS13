//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var tipButton: String?
    var tipRatio = 0.0
    var splitNumber = 2
    var textTyped = ""
    var totalPerPerson = 0.0
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let tipSelected = sender.currentTitle!
        tipButton = sender.currentTitle
        tipRatio = Double(String(tipSelected.dropLast()))! / 100
        billTextField.endEditing(true)

        

    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
        splitNumber = Int(sender.value)
        billTextField.endEditing(true)

    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        textTyped = billTextField.text ?? ""
        totalPerPerson = (Double(textTyped) ?? 123.56) * (1 + tipRatio) / Double(splitNumber)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = String(format: "%.2f", totalPerPerson)
            destinationVC.splitNumber = splitNumber
            destinationVC.tip = tipButton
        }
    }
    
}

