//
//  ProjectDataSource.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 20/2/23.
//

import Foundation

protocol ProjectDataSource {
    func fetchLocalizables(_ searchPaths: [String]) async throws -> Set<String>
    func fetchWhiteListKeys() async throws -> Set<String>
}
