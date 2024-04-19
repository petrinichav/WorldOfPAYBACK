//
//  NetworkClient.swift
//  PlantRecognizer
//
//  Created by Aliaksei Piatrynich on 26/03/2024.
//

import Foundation
import UIKit
import SwiftUI

fileprivate enum NetworkConstants {
    #if DEBUG
    static let domainURL = "https://api-test.payback.com/"
    #else
    static let domainURL = "https://api.payback.com/"
    #endif
}

enum RequestError: LocalizedError {
    case invalidURL
    case someError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            NSLocalizedString("error.invalidURL", comment: "")
        case .someError:
            NSLocalizedString("error.someError", comment: "")
        }
    }
}

protocol RequestData {
    associatedtype Model: Encodable
    var url: String { get }
    var model: Model { get }
}

enum Request {
    case transactions
    
    var url: String {
        switch self {
        case .transactions:
            return NetworkConstants.domainURL
        }
    }
}

extension Request {
    enum Method: String, CaseIterable {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    var method: Method {
        switch self {
        case .transactions:
            return .GET
        }
    }
}

// MARK: - RequestFactory
struct RequestFactory {
    func urlRequest(from request: Request) throws -> URLRequest? {
        switch request {
        case .transactions:
            guard let url = URL(string: request.url) else {
                throw RequestError.invalidURL
            }
            var urlRequest = URLRequest(url: url, timeoutInterval: 30)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return urlRequest
        }
    }
}

// MARK: - NetworkClient
struct NetworkClient: NetworkClientable {
    private let decoder: JSONDecoder = {
        JSONDecoder.decoder(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    }()
    
    func run<Response: Decodable>(request: Request) async throws -> Response {
        guard let urlRequest = try RequestFactory().urlRequest(from: request) else {
            throw RequestError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        return try decoder.decode(Response.self, from: data)
    }
}
