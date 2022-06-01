//
//  RegexMatcherTests.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation
import Nimble
import XCTest

@testable import LocalizerCore

class RegexMatcherTests: XCTestCase {
    
    var configuration: Configuration!
    var fileDataSource: FileDataSource!
    var sut: RegexMatcher!
    
    override func setUp() {
        super.setUp()
       
        configuration = Configurations.default
        fileDataSource = FileDataSourceImp()
        
        sut = RegexMatcherImp(configuration: configuration)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testFetchLocalizableKeys() {
        guard let filePath = Bundle.module.path(forResource: "example", ofType: "txt") else {
            XCTFail("File not found")
            return
        }
        
        var expectedLocalizables = Set<LocalizableString>()
        expectedLocalizables.insert(LocalizableString(key: "test1"))
        expectedLocalizables.insert(LocalizableString(key: "test2"))
        expectedLocalizables.insert(LocalizableString(key: "test3"))
        expectedLocalizables.insert(LocalizableString(key: "test4"))
        
        let localizables = sut.fetchLocalizableKeys(fromFile: filePath)
        
        expect(localizables).toNot(beEmpty())
        expect(localizables.isSubset(of: expectedLocalizables)).to(beTrue())
    }
}
