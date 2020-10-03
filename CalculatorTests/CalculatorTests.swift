//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Rohit Jangid on 21/09/20.
//

import XCTest

class CalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOperation() {
        XCTAssert(Calculation.performCalculation(firstNumber: "9", secondNumber: "1.5", operation: "÷") == 6)
        XCTAssert(Calculation.performCalculation(firstNumber: "8", secondNumber: "12.56", operation: "×") == 100.48)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
