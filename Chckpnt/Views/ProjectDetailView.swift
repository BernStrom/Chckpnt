//
//  ProjectDetailView.swift
//  Chckpnt
//
//  Created by Bern N on 12/28/23.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var newProjectUpdate: ProjectUpdate?
    @State private var showEditFocus = false
    
    var project: Project
    
    var body: some View {
        ZStack {
            // MARK: - Background Styles
            LinearGradient(
                colors: [Color("Navy"), Color("Sky Blue")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                colors: [Color("Washed Blue").opacity(0), Color("Sky Blue")],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 1)
            .padding(.leading, -150)
            
            VStack {
                // MARK: - Header
                VStack(alignment: .leading, spacing: 13) {
                    Text(project.name)
                        .font(.screenHeading)
                    
                    HStack(alignment: .center, spacing: 13) {
                        Spacer()
                        
                        StatBubbleView(title: "Hours", stat: project.hours, leadingColor: Color("Navy"), trailingColor: Color("Sky Blue"))
                        
                        StatBubbleView(title: "Sessions", stat: Double(project.sessions), leadingColor: Color("Turtle Green"), trailingColor: Color("Lime"))
                        
                        StatBubbleView(title: "Updates", stat: Double(project.updates.count), leadingColor: Color("Maroon"), trailingColor: Color("Fuschia"))
                        
                        StatBubbleView(title: "Wins", stat: Double(project.wins), leadingColor: Color("Maroon"), trailingColor: Color("Olive"))
                        
                        Spacer()
                    }
                    
                    Text("My current focus is...")
                        .font(.featuredText)
                    
                    HStack {
                        if project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                            Button {
                                completeMilestone()
                            } label: {
                                Image(systemName: "checkmark.square")
                            }
                        }
                        
                        Text(project.focus.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Tap to set your focus" : project.focus)
                            .font(.featuredText)
                            .onTapGesture {
                                // Display edit focus form
                                showEditFocus = true
                            }
                    }
                    .padding(.leading)
                }
                .foregroundStyle(.white)
                .padding()
                .background {
                    Color(.black)
                        .opacity(0.7)
                        .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                        .ignoresSafeArea()
                }
                // MARK: - Project Updates
                if project.updates.count > 0 {
                    ScrollView {
                        VStack(spacing: 27) {
                            ForEach(project.updates.sorted(by: { updateOne, updateTwo in
                                updateOne.date > updateTwo.date
                            })) { update in
                                ProjectUpdateView(update: update)
                                    .onTapGesture {}
                                    .onLongPressGesture {
                                        newProjectUpdate = update
                                    }
                            }
                        }
                        .padding()
                        .padding(.bottom, 80)
                    }
                    .scrollIndicators(.hidden)
                } else {
                    // Display a button prompt to the user for adding new project updates
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button("Tap to add new project update(s)") {
                            newProjectUpdate = ProjectUpdate()
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(.white)
                        .padding(.bottom, 100)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            // MARK: - Footer Buttons
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        newProjectUpdate = ProjectUpdate()
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black)
                                .frame(width: 65)
                            
                            Image("cross")
                        }
                    }
                    .padding([.leading, .top])
                    
                    Spacer()
                    
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                    .tint(.black)
                    .padding([.trailing, .top])
                }
                .background {
                    Color(.black)
                        .opacity(0.5)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(item: $newProjectUpdate) { update in
            let isEdit = update.headline.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            
            EditUpdateView(project: project, update: update, isEditMode: isEdit)
                .presentationDetents([.fraction(0.3)])
        }
        .sheet(isPresented: $showEditFocus) {
            EditFocusView(project: project)
                .presentationDetents([.fraction(0.2)])
        }
    }
    
    func completeMilestone() {
        // Create a new project update
        let update = ProjectUpdate()
        update.updateType = .milestone
        update.headline = "Milestone Achieved"
        update.summary = project.focus
        project.updates.insert(update, at: 0)
        
        // Force a manual save to SwiftData
        try? context.save()
        
        StatsHelper.updateAdded(project: project, update: update)
        
        // Clears the project focus
        project.focus = ""
    }
}

//#Preview {
//    ProjectDetailView(project: Project())
//}
