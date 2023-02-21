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
    
    let parameters = Parameters(
        localizableFilePath: "~/Desktop/Proyectos/manu/ios/Localizer/Tests/LocalizerTests/Resources/LocalizerExampleProject/LocalizerExampleProject/Localizables",
        searchPaths: [
            "~/Desktop/Proyectos/manu/ios/Localizer/Tests/LocalizerTests/Resources/LocalizerExampleProject/LocalizerExampleProject"
        ]
    )
    
    override func setUp() {
        super.setUp()
        
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
