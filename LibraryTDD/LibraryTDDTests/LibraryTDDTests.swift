//
//  LibraryTDDTests.swift
//  LibraryTDDTests
//
//  Created by 최혜선 on 18/07/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import XCTest

struct Book {
    var title: String
    var author: String
    var publisher: String
    var isLoan: Bool
    var resvCount: Int
    var returnDay: Date?
    
    enum LoanError: Error {
        case loanError
        case notLoanError
    }
    
    enum ResvError: Error {
        case resvFullError
    }
    
    enum ReturnError: Error {
        case notLoanError
    }
    
    mutating func loan() throws {
        guard !isLoan else {
            throw LoanError.loanError
        }
        
        self.isLoan = true
    }
    
    mutating func reservation() throws {
        guard isLoan else {
            throw LoanError.notLoanError
        }
        guard resvCount != 5 else {
            throw ResvError.resvFullError
        }
        
        resvCount += 1
    }
    
    mutating func returnBook() throws {
        guard isLoan else {
            throw ReturnError.notLoanError
        }
        
        self.isLoan = false
        self.returnDay = nil
    }
    
    func checkToReturnState() -> Bool {
        guard isLoan else {
            return false
        }
        
        guard let returnDay = returnDay else {
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())
        return today == dateFormatter.string(from: returnDay)
    }
}

class Library {
    private var books: [Book] = []
    
    init() {
        books.append(Book(title: "테스트 주도 개발", author: "켄트 벡", publisher: "인사이트(insight)", isLoan: true, resvCount: 5, returnDay: Date()))
        books.append(Book(title: "여행의 이유", author: "김영하", publisher: "문학동네", isLoan: true, resvCount: 3, returnDay: Date()))
        books.append(Book(title: "설민석의 삼국지", author: "설민석", publisher: "세계사", isLoan: false, resvCount: 0, returnDay: nil))
        books.append(Book(title: "아주 작은 습관의 힘", author: "제임스 클리어", publisher: "비즈니스북스", isLoan: true, resvCount: 4, returnDay: Date()))
        books.append(Book(title: "죽음 1", author: "베르나르 베르베르", publisher: "열린책들", isLoan: false, resvCount: 0, returnDay: nil))
        books.append(Book(title: "Go Go 카카오프렌즈 9", author: "김미영", publisher: "아울북", isLoan: true, resvCount: 0, returnDay: nil))
    }
    
    func isExistBookHaveTitle(_ title: String) -> Bool {
        return books.contains { $0.title == title }
    }
    
    func getBook(title: String) -> Book {
        return books.filter { $0.title.contains(title) }.first!
    }
    
    func autoReturnToLoanBooks() throws {
        try books.filter { $0.checkToReturnState() }.forEach {
            var book = $0
            try book.returnBook()
        }
    }
}

class LibraryTDDTests: XCTestCase {
    
    let library = Library()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsHaveBookInLibrary() {
        XCTAssertTrue(library.isExistBookHaveTitle("테스트 주도 개발"))
        XCTAssertFalse(library.isExistBookHaveTitle("책"))
    }
    
    func testIsOnLoan() {
        // 책 대출 여부 확인
        let oneBook = library.getBook(title: "테스트 주도 개발")
        XCTAssertEqual(false, oneBook.isLoan)
    }
    
    func testLoanTheBook() {
        var bookToLoan = library.getBook(title: "여행의 이유")
        XCTAssertThrowsError(try bookToLoan.loan())
        
        var bookToLoan2 = library.getBook(title: "테스트 주도 개발")
        XCTAssertNoThrow(try bookToLoan2.loan())
    }
    
    func testReservationTheBook() {
        // 예약 full
        var bookToResv = library.getBook(title: "테스트 주도 개발")
        XCTAssertThrowsError(try bookToResv.reservation())
        
        // 미대출 도서
        var bookToResv2 = library.getBook(title: "설민석의 삼국지")
        XCTAssertThrowsError(try bookToResv2.reservation())
        
        // 예약 후 추가 예약
        var resvFullTest = library.getBook(title: "아주 작은 습관의 힘")
        XCTAssertNoThrow(try resvFullTest.reservation())
        // 예약 수가 5건이므로 full resv error
        XCTAssertThrowsError(try resvFullTest.reservation())
    }
    
    func testReturnLoanBook() {
        // 책 반납
        var willReturnBook = library.getBook(title: "테스트 주도 개발")
        XCTAssertNoThrow(try willReturnBook.returnBook())
    }
    
    func testAutoReturnToLoanBook() {
        // 자동 반납 테스트
        let willReturnBook = library.getBook(title: "테스트 주도 개발")
        // 책 한권에 대한 반납일 체크
        XCTAssertTrue(willReturnBook.checkToReturnState())
        // 전체 책 반납일 체크 및 반납
        XCTAssertNoThrow(try library.autoReturnToLoanBooks())
    }
}
