//
//  LocalizableDataSourceTests.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 1/3/23.
//

import XCTest

@testable import Localizer

final class LocalizableDataSourceTests: XCTestCase {

    var sut: LocalizablesDataSourceImp!
    
    var resourcesURL: URL {
        let resourcesPath = Bundle.module.resourcePath!
        return URL(fileURLWithPath: resourcesPath)
    }
        
    var projectTestPath: String {
        return resourcesURL.appendingPathComponent("LocalizerExampleProject/LocalizerExampleProject").path
    }
    
    var localizablesPath: String {
        return resourcesURL.appendingPathComponent("LocalizerExampleProject/LocalizerExampleProject/Localizables").path
    }
    
    var parameters: CompareParameters {
        return  CompareParameters(
            localizableFilePath: localizablesPath,
            searchPaths: [projectTestPath],
            unlocalizedKeys: false,
            verbose: true
        )
    }
    
    override func setUp() {
        super.setUp()
    
        print(projectTestPath)
        
        sut = LocalizablesDataSourceImp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testCompareLocalizables() async {
        do {
            try await sut.compare(parameters)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testCompareLocalizablesPerformance() {
        self.measure {
            Task {
                await self.testCompareLocalizables()
            }
        }
    }
}
