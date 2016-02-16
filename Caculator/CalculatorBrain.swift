//
//  CalculatorBrain.swift
//  Caculator
//
//  Created by WangXin on 2/15/16.
//  Copyright © 2016 WangXin. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = [Op]()
    
    private var knownOps = Dictionary<String, Op>()
//    var knownOps = [String:Op]()
    
    init(){
        knownOps["×"] = Op.BinaryOperation("×", {$0 * $1})
        knownOps["÷"] = Op.BinaryOperation("/", {$1 / $0})
        knownOps["+"] = Op.BinaryOperation("+", {$0 + $1})
        knownOps["-"] = Op.BinaryOperation("-", {$1 - $0})
        knownOps["√"] = Op.UnaryOperation("√", {sqrt($0)})
    }
    
    private func evaluateStack(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        print(ops)
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluateStack(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluateStack(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluateStack(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluateStack(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
}