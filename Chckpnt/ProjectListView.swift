//
//  ProjectListView.swift
//  Chckpnt
//
//  Created by Bern N on 12/25/23.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    @State private var newProject: Project?
    @Query private var projects: [Project]
    
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
                                NavigationLink {
                                    ProjectDetailView(project: project)
                                } label: {
                                    ProjectCardView(project: project)
                                }
                                .buttonStyle(.plain)
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
            AddProjectView(project: project)
                .presentationDetents([.fraction(0.2)])
        }
    }
}

#Preview {
    ProjectListView()
}
