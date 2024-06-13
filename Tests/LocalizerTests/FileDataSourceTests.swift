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
    
    let configuration: Configuration = .default
    
    override func setUp() {
        super.setUp()
        
        sut = FilesDataSourceImp()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testFetchFile() {
        do {
            let files = try sut.fetchRecursiveFiles(fromPath: projectTestPath, extensions: configuration.formatsSupported)
            XCTAssertFalse(files.isEmpty)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFetchInvalidFile() {
        let badPath = projectTestPath.appending("BAD")
        XCTAssertThrowsError(try sut.fetchRecursiveFiles(fromPath: badPath, extensions: configuration.formatsSupported))
    }
}
