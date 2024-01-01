//
//  EditFocusView.swift
//  Chckpnt
//
//  Created by Bern N on 1/1/24.
//

import SwiftUI

struct EditFocusView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var focus = ""
    
    var project: Project
 
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Edit Project Focus")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                HStack {
                    TextField("Focus", text: $focus)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Save") {
                        // Save project focus
                        project.focus = focus
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(focus.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

//#Preview {
//    EditFocusView()
//}
