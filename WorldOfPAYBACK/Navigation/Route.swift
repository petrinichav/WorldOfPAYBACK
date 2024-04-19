//
//  Route.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import Foundation

enum Route: Hashable {
    case transactions
    case filter
    case details(Transactions.Item)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .transactions:
            hasher.combine("transactions")
            
        case .filter:
            hasher.combine("filter")
            
        case .details(let item):
            hasher.combine(item)
        }
    }
}
