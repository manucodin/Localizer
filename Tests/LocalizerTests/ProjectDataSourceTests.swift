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
            unlocalizedKeys: false,
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
        do {
            let projectLocalizables = try await sut.fetchLocalizables()

            XCTAssertTrue(projectLocalizables.count == 7)
            XCTAssertFalse(projectLocalizables.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
