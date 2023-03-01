//
//  LocalizableDataSourceTests.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 1/3/23.
//

import XCTest

@testable import Localizer

final class LocalizableDataSourceTests: XCTestCase {

    private var sut: LocalizablesDataSourceImp!
    
    private var resourcesURL: URL {
        let resourcesPath = Bundle.module.resourcePath!
        return URL(fileURLWithPath: resourcesPath)
    }
        
    private var projectTestPath: String {
        return resourcesURL.appendingPathComponent("LocalizerExampleProject/LocalizerExampleProject").path
    }
    
    private var localizablesPath: String {
        return resourcesURL.appendingPathComponent("LocalizerExampleProject/LocalizerExampleProject/Localizables").path
    }
    
    private var parameters: Parameters {
        return  Parameters(
            localizableFilePath: localizablesPath,
            searchPaths: [projectTestPath],
            verbose: true
        )
    }
    
    override func setUp() {
        super.setUp()
    
        print(projectTestPath)
        
        sut = LocalizablesDataSourceImp(parameters: parameters, configuration: .default)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testCompareLocalizables() async {
        do {
            try await sut.compare()
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
