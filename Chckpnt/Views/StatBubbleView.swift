//
//  StatBubbleView.swift
//  Chckpnt
//
//  Created by Bern N on 12/26/23.
//

import SwiftUI

struct StatBubbleView: View {
    var title: String
    var stat: Double
    var leadingColor: Color
    var trailingColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        colors: [leadingColor, trailingColor],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            VStack {
                Text(title)
                    .font(.captionText)
                Text(TextHelper.convertStat(input: stat))
                    .font(.featuredNumber)
                    .bold()
            }
            .foregroundStyle(.white)
        }
        .frame(width: 60, height: 40)
    }
}

#Preview {
    StatBubbleView(title: "Hours", stat: 290.0, leadingColor: Color("Navy"), trailingColor: Color("Blue"))
}
