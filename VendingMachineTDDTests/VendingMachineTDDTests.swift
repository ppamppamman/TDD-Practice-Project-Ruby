//
//  VendingMachineTDDTests.swift
//  VendingMachineTDDTests
//
//  Created by 최혜선 on 01/06/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

enum Coin: Int, CaseIterable {
    case unit500 = 500
    case unit100 = 100
    case unit50 = 50
    case unit10 = 10
    
    var value: Int {
        return self.rawValue
    }
}

class CoinBundle {
    private var coins: [Coin] = []
    
    var totalMoney: Int {
        return coins.map { $0.value }.reduce(0) { $0 + $1 }
    }
    
    func add(_ coin: Coin) {
        coins.append(coin)
    }
    
    func remove(_ money: Int) {
        let remain = totalMoney - money
        coins = convert(money: remain)
    }
    
    private func convert(money: Int) -> [Coin] {
        var money = money
        var newCoins: [Coin] = []
        
        Coin.allCases.sorted(by: {$0.value > $1.value}).forEach {
            let convertedCoins = convert(money: money, by: $0)
            money -= ($0.value * convertedCoins.count)
            newCoins += convertedCoins
        }
        
        return newCoins
    }
    
    private func convert(money: Int, by coin: Coin) -> [Coin] {
        guard money / coin.value > 0 else { return [] }
        let count = money / coin.value
        return Array(repeating: coin, count: count)
    }
    
    func getCoinCount(of coin: Coin) -> Int {
        return coins.filter { $0 == coin }.count
    }
}

class VendingMachine {
    enum InsertError: Error {
        case invalidation
    }
    
    enum BuyError: Error {
        case notEnoughMoney
    }
    
    private var coinBundle = CoinBundle()
    
    func insertMoney(_ input: Int) throws {
        guard let coin = Coin(rawValue: input) else { throw InsertError.invalidation }
        coinBundle.add(coin)
    }
    
    func getTotalMoney() -> Int {
        return coinBundle.totalMoney
    }
    
    func getDrink(_ input: Int) throws {
        if input > coinBundle.totalMoney {
            throw BuyError.notEnoughMoney
        }
        coinBundle.remove(input)
    }
    
    func getCoinsCount(_ coin: Coin) -> Int {
        return coinBundle.getCoinCount(of: coin)
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
