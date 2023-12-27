//
//  ProjectDetailView.swift
//  Chckpnt
//
//  Created by Bern N on 12/28/23.
//

import SwiftUI

struct ProjectDetailView: View {
    @Environment(\.dismiss) private var dismiss
    var project: Project
    
    var body: some View {
        VStack {
            Text(project.name)
                .navigationBarBackButtonHidden()
            
            Button("Back") {
                dismiss()
            }
        }
    }
}

#Preview {
    ProjectDetailView(project: Project())
}
