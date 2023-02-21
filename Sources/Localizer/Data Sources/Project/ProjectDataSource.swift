//
//  ProjectDataSource.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 20/2/23.
//

import Foundation

protocol ProjectDataSource {
    func fetchLocalizables() async throws -> Set<String>
}
