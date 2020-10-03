//
//  Calculation.swift
//  CoolCalc
//
//  Created by Rohit Jangid on 15/09/20.
//  Copyright © 2020 Rohit Jangid. All rights reserved.
//

import Foundation

//struct Equation {
//    var equation = [String]()
//}

class Calculation {
    class func performCalculation(firstNumber: String, secondNumber: String, operation: String) -> Double {
        var result: Double = 0
        
        guard let firstNum = Double(firstNumber), let secondNum = Double(secondNumber) else { return result }
                
        switch operation {
        case "÷":
            result = firstNum / secondNum
        case "×":
            result = firstNum * secondNum
        case "+":
            result = firstNum + secondNum
        case "-":
            result = firstNum - secondNum
//        case "+/−":
//            result = firstNum * -1
        case "%":
            result = firstNum / 100
        default:
            break
        }
        return result
    }
}
