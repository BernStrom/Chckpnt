//
//  ProjectListView.swift
//  Chckpnt
//
//  Created by Bern N on 12/25/23.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Query private var projects: [Project]
    
    @State private var newProject: Project?
    @State private var selectedProject: Project?
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color("Deep Purple"), Color("Blush Pink")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("Projects")
                        .font(.screenHeading)
                        .foregroundStyle(.white)
                    
                    if projects.count > 0 {
                        // Shows a list of project(s) if there are any
                        ScrollView {
                            VStack(alignment: .leading, spacing: 26) {
                                ForEach(projects) { project in
                                    ProjectCardView(project: project)
                                        .onTapGesture {
                                            selectedProject = project
                                        }
                                        .onLongPressGesture {
                                            newProject = project
                                        }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    } else {
                        // Display a button prompt to the user for adding a new project
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button("Tap to add a new project") {
                                newProject = Project()
                            }
                            .buttonStyle(.bordered)
                            .foregroundStyle(.white)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    
                }
                .padding()
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            newProject = Project()
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 65)
                                    .foregroundStyle(.black)
                                
                                Image("cross")
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding(.leading)
            }
            .navigationDestination(item: $selectedProject) { project in
                ProjectDetailView(project: project)
            }
        }
        .sheet(item: $newProject) { project in
            let isEdit = project.name.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            
            EditProjectView(project: project, isEditMode: isEdit)
                .presentationDetents([.fraction(0.2)])
        }
    }
}

#Preview {
    ProjectListView()
}
