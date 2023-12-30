//
//  ProjectUpdateView.swift
//  Chckpnt
//
//  Created by Bern N on 12/31/23.
//

import SwiftUI

struct ProjectUpdateView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .shadow(radius: 5, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Thursday, September 12, 2023")
                        .padding(.leading)
                    
                    Spacer()
                    
                    Text("9 Hours")
                        .padding(.trailing)
                }
                .padding(.vertical, 5)
                .background {
                    Color("Orchid")
                }
                
                Text("Project headline")
                    .font(.smallHeadline)
                    .padding(.horizontal)
                
                Text("Project summary")
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .foregroundStyle(.white)
            .font(.regularText)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ProjectUpdateView()
}
