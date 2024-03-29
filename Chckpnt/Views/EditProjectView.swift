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
                        .onChange(of: projectName) { oldValue, newValue in
                            projectName = TextHelper.limitCharacters(input: projectName, limit: 30)
                        }
                    
                    Button(isEditMode ? "Save" : "Add") {
                        if isEditMode {
                            // Edit existing project
                            project.name = projectName
                        } else {
                            withAnimation {
                                // Add new project to SwiftData
                                project.name = projectName
                                context.insert(project)
                                
                                // Force a manual save to SwiftData
                                try? context.save()
                            }
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(projectName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    
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
                withAnimation {
                    // Delete project from SwiftData
                    context.delete(project)
                    
                    // Force a manual save to SwiftData
                    try? context.save()
                }
                
                dismiss()
            }
        }
        .onAppear {
            projectName = project.name
        }
    }
}
