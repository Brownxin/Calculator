//
//  ViewController.swift
//  Caculator
//
//  Created by WangXin on 2/13/16.
//  Copyright © 2016 WangXin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping: Bool = false
    
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton){
        let digit = sender.currentTitle!
//        print("digit = \(digit)")
        if userIsTyping{
            if display.text != "0"{
                display.text = display.text! + digit
            }
            else{
                display.text = digit
            }
        }
        else{
            display.text = digit
            userIsTyping = true
        }
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
    
//    var operandStack: Array<Double> = Array<Double>()
    
    @IBAction func enter() {
        userIsTyping = false
        //        operandStack.append(displayValue)
        //        print("operandStack = \(operandStack)")
        
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    
    @IBAction func Guarantee() {
        print(brain.program)
    }
    
    @IBAction func operation(sender: UIButton) {
        if userIsTyping{
            enter()
        }
        if let opera = sender.currentTitle{
            if let result = brain.performOperation(opera){
//                print(opera)
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
        /**
        The operation is done in the Model.
        */
//        switch opera {
//        case "+":
//            if operandStack.count >= 2 {
//                displayValue = operandStack.removeLast() + operandStack.removeLast()
//                enter()
//            }
//            perfromOperation{ $0 + $1 }
//        case "−":
//            if operandStack.count >= 2 {
//                displayValue = operandStack.removeLast() + operandStack.removeLast()
//                enter()
//            }
//            perfromOperation{ $1 - $0 }
//        case "✕":
//            if operandStack.count >= 2 {
//                displayValue = operandStack.removeLast() * operandStack.removeLast()
//                enter()
//            }
//            perfromOperation{ $0 * $1 }
//        case "÷":
//            if operandStack.count >= 2 {
//                displayValue = operandStack.removeLast() + operandStack.removeLast()
//                enter()
//            }
//            perfromOperation{ $1 / $0 }
//        case "√":
//            perfromOperation_sqrt{ sqrt($0) }
//        default: break
//        }
        
    }
    
    /**
     The operation is done in the Model.
     */
//    func perfromOperation(operation: (Double, Double) -> Double) {
//        if operandStack.count >= 2{
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }
//    func perfromOperation_sqrt(operation: Double -> Double){
//        if operandStack.count >= 1{
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//        
//    }
//    func multiply(op1: Double, op2: Double) -> Double {
//        return op1 * op2
//    }
//    func divide(op1: Double, op2: Double) -> Double {
//        return op2 / op1
//    }
//    func plus(op1: Double, op2: Double) -> Double {
//        return op1 + op2
//    }
//    func minus(op1: Double, op2: Double) -> Double {
//        return op2 - op1
//    }
}