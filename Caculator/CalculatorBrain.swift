//
//  CalculatorBrain.swift
//  Caculator
//
//  Created by WangXin on 2/15/16.
//  Copyright © 2016 WangXin. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    var opStack = [Op]()
    
    var knownOps = Dictionary<String, Op>()
//    var knownOps = [String:Op]()
    
    init(){
        knownOps["×"] = Op.BinaryOperation("×", {$0 * $1})
        knownOps["÷"] = Op.BinaryOperation("/", {$1 / $0})
        knownOps["+"] = Op.BinaryOperation("×", {$0 + $1})
        knownOps["−"] = Op.BinaryOperation("×", {$1 - $0})
        knownOps["√"] = Op.UnaryOperation("√", {sqrt($0)})
    }
    
    func pushOperand(operand: Double){
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String){
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        
    }
}