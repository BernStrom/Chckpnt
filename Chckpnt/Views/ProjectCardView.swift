//
//  ProjectCardView.swift
//  Chckpnt
//
//  Created by Bern N on 12/26/23.
//

import SwiftUI

struct ProjectCardView: View {
    var project: Project
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.7)
                .shadow(radius: 5, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(project.name)
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                HStack(alignment: .center, spacing: 13) {
                    Spacer()
                    
                    StatBubbleView(title: "Hours", stat: project.hours, leadingColor: Color("Navy"), trailingColor: Color("Sky Blue"))
                    
                    StatBubbleView(title: "Sessions", stat: Double(project.sessions), leadingColor: Color("Turtle Green"), trailingColor: Color("Lime"))
                    
                    StatBubbleView(title: "Updates", stat: Double(project.updates.count), leadingColor: Color("Maroon"), trailingColor: Color("Fuschia"))
                    
                    StatBubbleView(title: "Wins", stat: Double(project.wins), leadingColor: Color("Maroon"), trailingColor: Color("Olive"))
                    
                    Spacer()
                }
                
                if project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                    Text("My current focus is...")
                        .font(.featuredText)
                        .foregroundStyle(.gray)
                    Text(project.focus)
                        .font(.featuredText)
                        .foregroundStyle(.gray)
                        .bold()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProjectCardView(project: Project())
}
