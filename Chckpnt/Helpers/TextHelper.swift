//
//  TextHelper.swift
//  Chckpnt
//
//  Created by Bern N on 1/2/24.
//

import Foundation

struct TextHelper {
    static func convertStat(input: Double) -> String {
        switch input {
        case let stat where input > 1000:
            let dividedStat = stat / 1000
            return "\(round(dividedStat * 10) / 10)k"
        default:
            return String(Int(input))
        }
    }
    
    static func limitCharacters(input: String, limit: Int) -> String {
        if input.count > limit {
            return String(input.prefix(limit))
        }
        
        return input
    }
}
