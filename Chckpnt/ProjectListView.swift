//
//  ProjectListView.swift
//  Chckpnt
//
//  Created by Bern N on 12/25/23.
//

import SwiftUI

struct ProjectListView: View {
    var body: some View {
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
                        ProjectCardView()
                        ProjectCardView()
                        ProjectCardView()
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding()
            
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        
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
}

#Preview {
    ProjectListView()
}
