//
//  EditProjectView.swift
//  Chckpnt
//
//  Created by Bern N on 12/28/23.
//

import SwiftUI
import SwiftData

struct EditProjectView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var projectName = ""
    @State private var showDeleteConfirmation = false
    
    var project: Project
    var isEditMode: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(isEditMode ? "Edit Project" : "Add Project")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                HStack {
                    TextField("Project name", text: $projectName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(isEditMode ? "Save" : "Add") {
                        if isEditMode {
                            // Edit existing project
                            project.name = projectName
                        } else {
                            // Add new project to SwiftData
                            project.name = projectName
                            context.insert(project)
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(projectName.trimmingCharacters(in: .whitespacesAndNewlines) == "")
                    
                    if isEditMode {
                        Button("Delete") {
                            showDeleteConfirmation = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .confirmationDialog("Delete this project?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button("Yes. delete it") {
                // Delete project from SwiftData
                context.delete(project)
                dismiss()
            }
        }
        .onAppear {
            projectName = project.name
        }
    }
}
