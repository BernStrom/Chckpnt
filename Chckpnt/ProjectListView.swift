//
//  ProjectListView.swift
//  Chckpnt
//
//  Created by Bern N on 12/25/23.
//

import SwiftUI

struct ProjectListView: View {
    var body: some View {
        VStack {
            Image("cross")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.screenHeading)
                .foregroundStyle(Color("Olive"))
        }
        .padding()
    }
}

#Preview {
    ProjectListView()
}
