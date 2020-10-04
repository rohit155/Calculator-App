//
//  ViewController.swift
//  Calculator
//
//  Created by Rohit Jangid on 19/09/20.
//

import UIKit

class CalculatorVC: UIViewController {
    
    var inputEquation = [String]()
    var number: String = ""
    var isDecimal: Bool = false
    var performMath: Bool = false
    var isLastNumber: Bool = false
    var operation: String = ""
    var lastValue: String = ""
    
    @IBOutlet weak var resultScreen: UILabel!
    @IBOutlet weak var clearButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultScreen.text = "0"
    }
    
    
    @IBAction func numberPressed(_ sender: RoundedButton) {
        print(sender.titleLabel?.text ?? "buttons not working")
        clearButton.setTitle("C", for: .normal)
        isLastNumber = true
        let num = sender.titleLabel?.text ?? "This should never trigger (numberPressed)"
        if num.contains("."){
            if !isDecimal {
                isDecimal = true
                number += num
                resultScreen.text = number
            }
            return
        }
        number += sender.titleLabel?.text ?? "This should never trigger (numberPressed)"
        resultScreen.text = number
    }
    
    
    @IBAction func operatorPressed(_ sender: RoundedButton) {
        let operation = sender.titleLabel?.text ?? "operatorPressed issue"
        if sender.tag == 1 {
            clearAll()
            return
        }
        if operation.contains("+/-"){
            handleNegativeNumber(operation)
            return
        }
        //checks whether last input was a number i.e - (to avoid two operator , + + , - + , etc)
        if isLastNumber || inputEquation.last == "%" {
            handleOperator(operation)
            self.operation = operation
            performMath = true
        }
    }
    
    
    @IBAction func equalPressed(_ sender: RoundedButton) {
        if performMath {
            if !number.isEmpty {
                inputEquation.append(number)
                lastValue = number
                number = ""
            }
            handleCalculation()
        }
    }
    
    
    //################# Clear function [Super Easy :)]
    func clearAll() {
        inputEquation = []
        number = ""
        isDecimal = false
        performMath = false
        isLastNumber = false
        operation = ""
        lastValue = ""
        resultScreen.text = "0"
        clearButton.setTitle("AC", for: .normal)
    }
    
    
    //################ Handling operater to perform on numbers ###############
    func handleOperator(_ optr: String) {
        if number.isEmpty {
            if !inputEquation.isEmpty {
                if inputEquation.last == optr {     //check for repeating operator
                    return
                }
                inputEquation.append(optr)
                print(inputEquation)
            }
            return
        }
        inputEquation.append(number)
        inputEquation.append(optr)
        lastValue = number
        isLastNumber = false
        isDecimal = false
        number = ""
        print(inputEquation)
    }
    
    
    //############### Handling nagative number i.e +/- button ################
    func handleNegativeNumber(_ num: String) {
        if number.isEmpty {
            return
        }
        guard var numDouble = Double(number) else { return }
        numDouble *= -1
        number = removeDecimal(numDouble)
        resultScreen.text = number
        print(inputEquation)
    }
    
    
    //############# Removing decimal #######################
    func removeDecimal(_ num: Double) -> String {
        if num.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(num))
        } else {
            return String(format: "%.2f", num)
        }
    }
    
    
    //################ Handling math for 1, 2 & array of string ##################
    func handleCalculation() {
        
        if inputEquation.count == 1 {
            resultScreen.text = inputEquation.first
            return
        }
        
        if inputEquation.count == 2 {
            let firstValue = inputEquation[0]
            operation = inputEquation[1]
            let result = getResult(firstnumber: firstValue, secondnumber: lastValue, finaloperation: operation)
            inputEquation[0] = result
            
            //############ removing modulo after math i.e so that it doesn't stay in array ############
//            if let index = inputEquation.firstIndex(of: "%") {
//                inputEquation.remove(at: index)
//            }
            resultScreen.text = result
            return
        }
        
        if inputEquation.contains("%") {
            if let index = inputEquation.firstIndex(of: "%") {
                let result = getResult(firstnumber: inputEquation[index - 1], secondnumber: inputEquation[index - 1], finaloperation: inputEquation[index])
                inputEquation[index - 1] = result
                inputEquation.remove(at: index)
                handleCalculation()
                return
            }
        }
        if inputEquation.contains("÷") {
            if let index = inputEquation.firstIndex(of: "÷") {
                if let divideByZeroException = Double(inputEquation[index + 1] ), divideByZeroException == 0 {
                    resultScreen.text = "Error"
                    return
                }
                getResultnew(index: index)
                return
            }
        }
        if inputEquation.contains("×") {
            if let index = inputEquation.firstIndex(of: "×") {
                getResultnew(index: index)
                return
            }
        }
        if inputEquation.contains("+") {
            if let index = inputEquation.firstIndex(of: "+") {
                getResultnew(index: index)
                return
            }
        }
        if inputEquation.contains("-") {
            if let index = inputEquation.firstIndex(of: "-") {
                getResultnew(index: index)
                return
            }
        }
        
    }
    
    
    //######### Getting result for 2 elements #######################
    func getResult(firstnumber: String, secondnumber: String, finaloperation: String) -> String {
        
        let answer = Calculation.performCalculation(firstNumber: firstnumber, secondNumber: secondnumber, operation: finaloperation)
        return removeDecimal(answer)
    }
    
    
    
    //############## Getting result for entire list of string ################
    func getResultnew(index: Int) {
        guard inputEquation.indices.contains(index + 1) else { return }
        let firstN = inputEquation[index - 1]
        let secondN = inputEquation[index + 1]
        let optr = inputEquation[index]
        
        let answer = Calculation.performCalculation(firstNumber: firstN, secondNumber: secondN, operation: optr)
        let result = removeDecimal(answer)
        
        inputEquation[index - 1] = result
        inputEquation.remove(at: index + 1)
        inputEquation.remove(at: index)
        handleCalculation()
    }
}

