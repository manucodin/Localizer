//
//  Matchable.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation

protocol Matchable {
    func compare(_ parameters: CompareParameters) async throws
    func search(_ parameters: SearchParameters) async throws
}
