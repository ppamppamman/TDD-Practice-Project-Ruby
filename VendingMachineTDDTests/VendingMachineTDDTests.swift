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
    
    func insertMoney(_ input: Int) throws {
        try validateInsertMoney(input)
    }
    
    func validateInsertMoney(_ input: Int) throws {
        if !(input == 10 || input == 50 || input == 100 || input == 500 || input == 1000) {
            throw InsertError.invalidation
        }
    }
}

class VendingMachineTDDTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsertMoneyValidation() {
        // 1000원까지 넣을 수 있음 10 50 100 500 1000
        let vendingMachine = VendingMachine()
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
    }
    
    func testInsertTotalMoney() {
        let vendingMachine = VendingMachine()
        XCTAssertNoThrow(try vendingMachine.insertMoney(500))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertNoThrow(try vendingMachine.insertMoney(100))
        XCTAssertEqual(vendingMachine.getMoney(), 700)
    }
}
