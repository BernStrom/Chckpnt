//
//  StatsHelper.swift
//  Chckpnt
//
//  Created by Bern N on 1/2/24.
//

import SwiftUI

struct StatsHelper {
    static func updateAdded(project: Project, update: ProjectUpdate) {
        // Update hours
        project.hours += update.hours
        
        // Update wins
        if update.updateType == .milestone {
            project.wins += 1
        }
        
        let sortedUpdates = project.updates.sorted { updateOne, updateTwo in
            updateOne.date > updateOne.date
        }
        
        if sortedUpdates.count >= 2 {
            let date1 = sortedUpdates[0].date
            let date2 = sortedUpdates[1].date
            
            if !Calendar.current.isDate(date1, inSameDayAs: date2) {
                project.sessions += 1
            }
        } else  {
            project.sessions += 1
        }
    }
    
    static func updateDeleted(project: Project, update: ProjectUpdate) {
        project.hours -= update.hours
        
        if update.updateType == .milestone {
            project.wins -= 1
        }
        
        let sameDayUpdates = project.updates.filter { u in
            Calendar.current.isDate(u.date, inSameDayAs: update.date)
        }
        
        if sameDayUpdates.count == 0 {
            project.sessions -= 1
        }
    }
    
    static func updateEdited(project: Project, hoursDifference: Double) {
        project.hours += hoursDifference
    }
}
