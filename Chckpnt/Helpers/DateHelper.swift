//
//  DateHelper.swift
//  Chckpnt
//
//  Created by Bern N on 1/1/24.
//

import Foundation

struct DateHelper {
    static func projectUpdateDate(inputDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        return formatter.string(from: inputDate)
    }
}
