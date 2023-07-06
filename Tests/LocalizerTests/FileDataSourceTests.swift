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
    
    private let configuration: Configuration = .default
    
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
