//
//  ProjectDetailView.swift
//  Chckpnt
//
//  Created by Bern N on 12/28/23.
//

import SwiftUI

struct ProjectDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var update: ProjectUpdate?
    
    var project: Project
    
    var body: some View {
        ZStack {
            // MARK: - Background Styles
            LinearGradient(
                colors: [Color("Navy"), Color("Sky Blue")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                colors: [Color("Washed Blue").opacity(0), Color("Sky Blue")],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 1)
            .padding(.leading, -150)
            
            VStack {
                // MARK: - Header
                VStack(alignment: .leading, spacing: 13) {
                    Text(project.name)
                        .font(.screenHeading)
                    
                    HStack(alignment: .center, spacing: 13) {
                        Spacer()
                        
                        StatBubbleView(title: "Hours", stat: "290", leadingColor: Color("Navy"), trailingColor: Color("Sky Blue"))
                        
                        StatBubbleView(title: "Sessions", stat: "34", leadingColor: Color("Turtle Green"), trailingColor: Color("Lime"))
                        
                        StatBubbleView(title: "Updates", stat: "32", leadingColor: Color("Maroon"), trailingColor: Color("Fuschia"))
                        
                        StatBubbleView(title: "Wins", stat: "9", leadingColor: Color("Maroon"), trailingColor: Color("Olive"))
                        
                        Spacer()
                    }
                    
                    Text("My current focus is...")
                        .font(.featuredText)
                    
                    HStack {
                        Image(systemName: "checkmark.square")
                        Text("Design the new app")
                            .font(.featuredText)
                    }
                    .padding(.leading)
                }
                .foregroundStyle(.white)
                .padding()
                .background {
                    Color(.black)
                        .opacity(0.7)
                        .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                        .ignoresSafeArea()
                }
                // MARK: - Project Updates
                ScrollView {
                    VStack(spacing: 27) {
                        ForEach(project.updates) { update in
                            ProjectUpdateView(update: update)
                        }
                    }
                    .padding()
                    .padding(.bottom, 80)
                }
                .scrollIndicators(.hidden)
            }
            // MARK: - Footer Buttons
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        update = ProjectUpdate()
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black)
                                .frame(width: 65)
                            
                            Image("cross")
                        }
                    }
                    .padding([.leading, .top])
                    
                    Spacer()
                    
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                    .tint(.black)
                    .padding([.trailing, .top])
                }
                .background {
                    Color(.black)
                        .opacity(0.5)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(item: $update) { update in
            AddUpdateView(project: project, update: update)
                .presentationDetents([.fraction(0.3)])
        }
    }
}

//#Preview {
//    ProjectDetailView(project: Project())
//}
