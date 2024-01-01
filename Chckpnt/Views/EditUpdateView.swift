//
//  EditUpdateView.swift
//  Chckpnt
//
//  Created by Bern N on 1/1/24.
//

import SwiftUI

struct EditUpdateView: View {
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
                   
                    Button(isEditMode ? "Save" : "Add") {
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)!
                        
                        if !isEditMode {
                            // Add project update
                            project.updates.insert(update, at: 0)
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
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
                // Remove updates from the project with the same id
                project.updates.removeAll { uniqueIdentifier in
                    uniqueIdentifier.id == update.id
                    
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
}

//#Preview {
//    AddUpdateView()
//}