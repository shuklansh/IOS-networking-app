//
//  QuoteView.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 13/04/24.
//

import SwiftUI

struct QuoteView: View {
    var body: some View {
        GeometryReader { geo in
            // used to adapt app to screen size
            ZStack {
                Image("breakingbad")
                    .resizable()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2
                    )
                VStack {
                    Text(
                        "\"ahsdbasbdhasbdhabdashbdashdbashdbahsbdhasbdadbhasbdahsbd\""
                    )
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame( width: geo.size.width)
                    .padding()
                }
            }
            .frame(
                width:geo.size.width,
                height:geo.size.height
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView()
        .preferredColorScheme(.dark)
}
