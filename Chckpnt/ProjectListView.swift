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
    @State private var showProjectDetail = false
    
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
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 26) {
                            ForEach(projects) { project in
                                ProjectCardView(project: project)
                                    .onTapGesture {
                                        showProjectDetail = true
                                    }
                                    .onLongPressGesture {
                                        newProject = project
                                    }
                                    .navigationDestination(isPresented: $showProjectDetail) {
                                        ProjectDetailView(project: project)
                                    }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
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
