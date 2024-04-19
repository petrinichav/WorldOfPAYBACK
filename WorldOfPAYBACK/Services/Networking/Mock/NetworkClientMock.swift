//
//  NetworkClientMock.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 17/04/2024.
//

import Foundation

struct NetworkClientMock: NetworkClientable {
    private let expectedResult: Result<Void, RequestError>
    
    init(expectedResult: Result<Void, RequestError>) {
        self.expectedResult = expectedResult
    }
    
    func run<Response>(request: Request) async throws -> Response where Response : Decodable {
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        switch expectedResult {
        case .success:
            switch request {
            case .transactions:
                return try RequestFactoryMock.transactions()
            }

        case .failure:
            throw RequestError.someError
        }
    }
}

private enum RequestFactoryMock {
    static func transactions<Response: Decodable>() throws -> Response {
        guard let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Error loading JSON file")
            throw RequestError.invalidURL
        }

        let decoder = JSONDecoder.decoder(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        
        let response = try decoder.decode(Response.self, from: data)
        return response
    }
}
