//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by bricK on 31/10/16.
//  Copyright © 2016 bricK. All rights reserved.
//

import Foundation //never import UIKit in a model file

class CalculatorBrain{
    
    private var accumulator: Double = 0.0
    private var pending : PendingBinaryOperationInfo?
    var result : Double {
        get{
            return accumulator
        }
    }
    struct PendingBinaryOperationInfo{
        var binaryFunction : ((Double,Double) -> Double)
        var firstOperand : Double
    }
    var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "x" : Operation.BinaryOperation({ return $0 * $1}),
        "/" : Operation.BinaryOperation({ return $0 / $1}),
        "+" : Operation.BinaryOperation({ return $0 + $1}),
        "-" : Operation.BinaryOperation({ return $0 - $1}),
        "=" : Operation.Equals
    ]
    
    enum Operation {//enum can have computed vars and methods, not normal vars
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        
    }
    
    func setOperand(operand : Double ) {
        accumulator = operand
    }
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedValue): accumulator = associatedValue
            case .UnaryOperation(let associatedFunction): accumulator = associatedFunction(accumulator)
            case .BinaryOperation(let associatedFunction):
                pending = PendingBinaryOperationInfo(binaryFunction: associatedFunction, firstOperand: accumulator)
            case .Equals :
                if pending != nil{
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                    pending = nil
                }
            }
            
        }
    }
    
}
