//
//  VendingMachineTDDTests.swift
//  VendingMachineTDDTests
//
//  Created by 최혜선 on 01/06/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

class VendingMachine {
    enum InsertError: Error {
        case invalidation
    }
    
    enum BuyError: Error {
        case notEnoughMoney
    }
    
    private var totalMoney: Int = 0
    
    func insertMoney(_ input: Int) throws {
        try validateInsertMoney(input)
        totalMoney += input
    }
    
    func validateInsertMoney(_ input: Int) throws {
        if !(input == 10 || input == 50 || input == 100 || input == 500 || input == 1000) {
            throw InsertError.invalidation
        }
    }
    
    func getTotalMoney() -> Int {
        return totalMoney
    }
    
    func getDrink(_ input: Int) throws {
        if input > totalMoney {
            throw BuyError.notEnoughMoney
        }
        totalMoney -= input
    }
    
    func getChangeCoinCount() -> Int {
        var totalCoinCount: Int = 0
        totalCoinCount += calculateCointCount(500)
        totalCoinCount += calculateCointCount(100)
        totalCoinCount += calculateCointCount(50)
        totalCoinCount += calculateCointCount(10)
        return totalCoinCount
    }
    
    private func calculateCointCount(_ base: Int) -> Int {
        var totalCoinCount: Int = 0
        if totalMoney / base > 0 {
            totalCoinCount += Int(totalMoney / base)
            totalMoney -= (Int(totalMoney / base) * base)
        }
        return totalCoinCount
    }
    
    func get500() -> Int {
        return calculateCointCount(500)
    }
    
    func get100() -> Int {
        return calculateCointCount(100)
    }
    
    func get50() -> Int {
        return calculateCointCount(50)
    }
    
    func get10() -> Int {
        return calculateCointCount(10)
    }
}

class VendingMachineTDDTests: XCTestCase {
    private let vendingMachine = VendingMachine()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsertMoneyValidation() {
        // 1000원까지 넣을 수 있음 10 50 100 500 1000
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
    }
    
    func testInsertTotalMoney() {
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertEqual(vendingMachine.getTotalMoney(), 700)
    }
    
    func testChangeCoinCount1() {
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.getDrink(500))
        XCTAssertEqual(vendingMachine.getChangeCoinCount(), 2)
        XCTAssertNoThrow(try vendingMachine.getDrink(100))
    }
    
    func testChangeCoinCount2() {
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.getDrink(350))
        XCTAssertEqual(vendingMachine.getChangeCoinCount(), 4)
    }
    
    func testChangeCoinCountPerUnit() {
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.getDrink(350))
        
        XCTAssertEqual(vendingMachine.get500(), 0)
        XCTAssertEqual(vendingMachine.get100(), 3)
        XCTAssertEqual(vendingMachine.get50(), 1)
        XCTAssertEqual(vendingMachine.get10(), 0)
    }
}
