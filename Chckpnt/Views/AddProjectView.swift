//
//  AddProjectView.swift
//  Chckpnt
//
//  Created by Bern N on 12/28/23.
//

import SwiftUI
import SwiftData

struct AddProjectView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var projectName = ""
    var project: Project
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("New Project")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                HStack {
                    TextField("Project name", text: $projectName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Save") {
                        project.name = projectName
                        context.insert(project)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
}
