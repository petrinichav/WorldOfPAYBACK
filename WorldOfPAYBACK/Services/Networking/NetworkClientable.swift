//
//  NetworkClientable.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 17/04/2024.
//

import Foundation

protocol NetworkClientable {
    func run<Response: Decodable>(request: Request) async throws -> Response
}
