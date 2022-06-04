//
//  FileDataSourceTests.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation
import Nimble
import XCTest

@testable import LocalizerCore

class FileDataSourceTests: XCTestCase {
    
    var sut: FileDataSource!
    
    override func setUp() {
        super.setUp()
        
        sut = FileDataSourceImp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testFetchFile() {
        guard let filePath = Bundle.module.path(forResource: "example", ofType: "txt") else {
            XCTFail("File not found")
            return
        }
        
        let encoding: String.Encoding = .utf8
        
        let fileContent = sut.fetchFileContent(fromPath: filePath, encoding: encoding)
        let expectedResult = "Hello world!"
        
        expect(fileContent).notTo(beNil())
        expect(fileContent?.contains(expectedResult)).to(beTrue())
    }
    
    func testFetchInvalidFile() {
        let filePath: String = "../Resources/unexpected.txt"
        let encoding: String.Encoding = .utf8
        
        let fileContent = sut.fetchFileContent(fromPath: filePath, encoding: encoding)
    
        expect(fileContent).to(beNil())
    }
}
