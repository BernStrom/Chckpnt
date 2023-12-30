//
//  Project.swift
//  Chckpnt
//
//  Created by Bern N on 12/25/23.
//

import Foundation
import SwiftData

@Model
class Project: Identifiable {
    
    @Attribute(.unique) var id: String
    var name = ""
    var startDate = Date()
    var focus = ""
    @Relationship(deleteRule: .cascade, inverse: \ProjectUpdate.project)
    var updates = [ProjectUpdate]()
    
    init() {
        id = UUID().uuidString
    }
    
}
