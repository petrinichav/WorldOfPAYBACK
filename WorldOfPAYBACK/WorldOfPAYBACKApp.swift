//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 16/04/2024.
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {
    @State private var routes: [Route] = []
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routes) {
                TransactionsScreen()
                    .environmentObject(
                        Self.transactionsClient
                    )
                    .environment(\.showError) { error in
                        errorWrapper = ErrorWrapper(error: error)
                    }
                    .sheet(item: $errorWrapper) { errorWrapper in
                        Text(errorWrapper.description)
                            .fontWeight(.medium)
                            .foregroundStyle(.red)
                            .padding()
                            .accessibilityIdentifier("error")
                    }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .transactions:
                            Text("")
                            
                        case .details(let item):
                            TransactionDetailsScreen(item: item)
                        }
                    }
            }.onNavigate { navigationType in
                switch navigationType {
                case .push(let route):
                    routes.append(route)
                    
                case .pop(let route):
                    print("Pop navigation")
                    switch route {
                    case .transactions:
                        routes = []
                        
                    default:
                        guard let index = routes.firstIndex(where: { $0 == route }) else { return }
                        routes = Array(routes.prefix(upTo: index + 1))
                    }
                }
            }
        }
    }
}

@MainActor
private extension WorldOfPAYBACKApp {
    static var transactionsClient: TransactionsClient {
        let fail = ProcessInfo.processInfo.environment["fail"]
        guard fail != nil else {
            return TransactionsClient(
                networkingClient: NetworkClientMock(
                    expectedResult: .success(Void())
                )
            )
        }
        return TransactionsClient(
            networkingClient: NetworkClientMock(
                expectedResult: .failure(.someError)
            )
        )
    }
}
