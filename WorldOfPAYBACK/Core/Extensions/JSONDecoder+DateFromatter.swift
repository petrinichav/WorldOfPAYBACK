//
//  JSONDecoder+DateFromatter.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 17/04/2024.
//

import SwiftUI

extension JSONDecoder {
    static func decoder(dateFormat: String) -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale.current
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
