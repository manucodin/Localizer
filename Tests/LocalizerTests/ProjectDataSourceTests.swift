//
//  ProjectDataSourceTests.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import XCTest
import Foundation

@testable import Localizer

final class ProjectDataSourceTests: XCTestCase {
    
    var sut: ProjectDataSourceImp!
    
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
        sut = ProjectDataSourceImp(parameters: parameters, configuration: .default)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testFetchLocalizableKeys() async {
        var expectedLocalizables = Set<String>()
        expectedLocalizables.insert("test1")
        expectedLocalizables.insert("test2")
        expectedLocalizables.insert("test3")
        expectedLocalizables.insert("test4")
 
        do {
            let localizables = try await sut.fetchLocalizables()
            
            debugPrint(localizables)
            XCTAssertFalse(localizables.isEmpty)
            XCTAssertTrue(expectedLocalizables.isSubset(of: localizables))
        } catch {
            XCTFail(error.localizedDescription)

        }
       
    }
    
}
