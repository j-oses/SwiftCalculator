//
//  ViewController.swift
//  Calculator
//
//  Created by bricK on 31/10/16.
//  Copyright © 2016 bricK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var brain = CalculatorBrain()
    
    @IBOutlet private weak var displayBar: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    private var displayValue: Double{
        get{
            return Double(displayBar.text!)! //We assume this is gonna be a number
        }
        set{
            displayBar.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton){
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTyping  {
            displayBar.text = displayBar.text! + digit
        } else {
            displayBar.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func doubleUp(_ sender: UIButton) {

        if displayBar.text!.range(of: ".") == nil {
            
            displayBar.text = displayBar.text! + "."
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
            
        }
        print(sender.currentTitle!)
        if let mathematicalSymbol = sender.currentTitle {//if the button is not empty then...
            
            brain.performOperation(symbol: mathematicalSymbol)
        }
       displayValue = Double(brain.result)
    }
    

  
    
}

