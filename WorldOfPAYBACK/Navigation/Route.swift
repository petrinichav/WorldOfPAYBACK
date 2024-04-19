//
//  Route.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import Foundation

enum Route: Hashable {
    case transactions
    case details(Transactions.Item)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .transactions:
            hasher.combine("transactions")
            
        case .details(let item):
            hasher.combine(item)
        }
    }
}
