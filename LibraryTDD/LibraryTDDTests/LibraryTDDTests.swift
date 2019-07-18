//
//  LibraryTDDTests.swift
//  LibraryTDDTests
//
//  Created by 최혜선 on 18/07/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

class LibraryTDDTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchBookInfo() {
        let book = Book("테스트 주도 개발")
        XCTAssertTrue(book.isExist())
    }
}
