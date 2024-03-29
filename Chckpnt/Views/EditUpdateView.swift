//
//  EditUpdateView.swift
//  Chckpnt
//
//  Created by Bern N on 1/1/24.
//

import SwiftUI
import SwiftData

struct EditUpdateView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var headline = ""
    @State private var summary = ""
    @State private var hours = ""
    @State private var showDeleteConfirmation = false
    
    var project: Project
    var update: ProjectUpdate
    var isEditMode: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(isEditMode ? "Edit Update" : "New Update")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                TextField("Headline", text: $headline)
                
                TextField("Summary", text: $summary, axis: .vertical)
                
                HStack {
                    TextField("Hours", text: $hours)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .onChange(of: hours) { oldValue, newValue in
                            hours = TextHelper.limitCharacters(input: hours, limit: 2)
                        }
                   
                    Button(isEditMode ? "Save" : "Add") {
                        // Calculates the hours difference to the current sum while editing the number of hours worked on the project
                        let hoursDifference = Double(hours)! - update.hours
                        
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)!
                        
                        if !isEditMode {
                            withAnimation {
                                // Add project update
                                project.updates.insert(update, at: 0)
                                
                                // Force a manual save to SwiftData
                                try? context.save()
                                
                                // Update project stats
                                StatsHelper.updateAdded(project: project, update: update)
                            }
                        } else {
                            withAnimation {
                                // Edit project update & update project stats
                                StatsHelper.updateEdited(project: project, hoursDifference: hoursDifference)
                            }
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(shouldDisable())
                    
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
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            .padding(.top)
        }
        .confirmationDialog("Delete project update?", isPresented: $showDeleteConfirmation) {
            Button("Yes, delete it") {
                withAnimation {
                    // Remove updates from the project with the same id
                    project.updates.removeAll { uniqueIdentifier in
                        uniqueIdentifier.id == update.id
                    }
                    
                    // Force a manual save to SwiftData
                    try? context.save()
                    
                    // Delete project stats from the deleted update
                    StatsHelper.updateDeleted(project: project, update: update)
                }
                
                dismiss()
            }
        }
        .onAppear {
            headline = update.headline
            summary = update.summary
            hours = String(Int(update.hours))
        }
    }
    
    private func shouldDisable() -> Bool {
        return headline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || summary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || hours.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

//#Preview {
//    AddUpdateView()
//}
