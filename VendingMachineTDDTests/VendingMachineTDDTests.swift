//
//  VendingMachineTDDTests.swift
//  VendingMachineTDDTests
//
//  Created by 최혜선 on 01/06/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

struct Coin {
    enum Unit: Int {
        case unit10 = 10
        case unit50 = 50
        case unit100 = 100
        case unit500 = 500
        case unit1000 = 1000
    }
    
    private let unit: Unit
    
    var value: Int {
        return unit.rawValue
    }
    
    init?(value: Int) {
        guard let unit = Unit(rawValue: value) else { return nil }
        self.unit = unit
    }
}

class VendingMachine {
    enum InsertError: Error {
        case invalidation
    }
    
    enum BuyError: Error {
        case notEnoughMoney
    }
    
    private var totalMoney: Int = 0
    
    func insertMoney(_ input: Int) throws {
        guard let coin = Coin(value: input) else { throw InsertError.invalidation }
        totalMoney += coin.value
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
    
    private func calculateCointCount(_ unit: Coin.Unit) -> Int {
        var totalCoinCount: Int = 0
        if totalMoney / unit.rawValue > 0 {
            totalCoinCount += Int(totalMoney / unit.rawValue)
            totalMoney -= (Int(totalMoney / unit.rawValue) * unit.rawValue)
        }
        return totalCoinCount
    }
    
    func getCoinsCount(_ unit: Coin.Unit) -> Int {
        return calculateCointCount(unit)
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
    
    func testChangeCoinCountPerUnit() {
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.getDrink(350))
        
        XCTAssertEqual(vendingMachine.getCoinsCount(.unit500), 0)
        XCTAssertEqual(vendingMachine.getCoinsCount(.unit100), 3)
        XCTAssertEqual(vendingMachine.getCoinsCount(.unit50), 1)
        XCTAssertEqual(vendingMachine.getCoinsCount(.unit10), 0)
    }
}
