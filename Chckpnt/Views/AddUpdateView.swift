//
//  AddUpdateView.swift
//  Chckpnt
//
//  Created by Bern N on 1/1/24.
//

import SwiftUI

struct AddUpdateView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var headline = ""
    @State private var summary = ""
    @State private var hours = ""
    
    var project: Project
    var update: ProjectUpdate
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("New Update")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                TextField("Headline", text: $headline)
                
                TextField("Summary", text: $summary, axis: .vertical)
                
                HStack {
                    TextField("Hours", text: $hours)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                   
                    Button("Save") {
                        // Save Project Update
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)!
                        project.updates.insert(update, at: 0)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
                
                Spacer()
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

//#Preview {
//    AddUpdateView()
//}
