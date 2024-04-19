//
//  NavigationType.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import Foundation

enum NavigationType: Hashable {
    case push(Route)
    case pop(Route)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .push(let route),
             .pop(let route):
            hasher.combine(route)
        }
    }
}
