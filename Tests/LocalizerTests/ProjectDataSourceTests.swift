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
        
        sut = ProjectDataSourceImp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testFetchLocalizableKeys() async {
        do {
            let projectLocalizables = try await sut.fetchLocalizables([projectTestPath])

            XCTAssertTrue(projectLocalizables.count == 8)
            XCTAssertFalse(projectLocalizables.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
