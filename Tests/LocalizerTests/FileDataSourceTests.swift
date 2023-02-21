//
//  FileDataSourceTests.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import XCTest
import Foundation

@testable import Localizer

class FileDataSourceTests: XCTestCase {
    
    var sut: FilesDataSourceImp!
    
    override func setUp() {
        super.setUp()
        
        sut = FilesDataSourceImp()
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

        do {
            let fileContent = try sut.fetchFileContent(fromPath: filePath, encoding: .utf8)

            XCTAssertNotNil(fileContent)
            XCTAssertTrue(fileContent.contains("Hello world!"))
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFetchInvalidFile() {
        XCTAssertThrowsError(try sut.fetchFileContent(fromPath: "../Resources/unexpected.txt", encoding: .utf8))
    }
}
