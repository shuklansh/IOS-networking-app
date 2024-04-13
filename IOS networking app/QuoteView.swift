//
//  QuoteView.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 13/04/24.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController()) 
    // instantiates observable
    let show: String
    var body: some View {
        GeometryReader { geo in
            // used to adapt app to screen size
            ZStack {
                Image(show.lowercased().filter { $0 != " " })
                    .resizable()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2
                    )
                VStack {
                    Spacer(minLength: 140)
                    switch viewModel.status {
                        case .SUCCESS(let data):
                            Text(
                                "\"\(data.quote.quote)\""
                            )
                            .padding(.horizontal)
                            .background(.black.opacity(0.5))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame( width: geo.size.width)
                            
                            ZStack(alignment: .bottom) {
                                Image("jessepinkman")
                                    .resizable()
                                    .scaledToFit()
                                Text( "pesse jinkman"
                                )
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.ultraThinMaterial)
                            }
                            .cornerRadius(24)
                            .frame(
                                width: geo.size.width * 0.7,
                                height: geo.size.height * 0.7
                            )
                        case .IN_PROGRESS:
                        ZStack(alignment: .bottom) {
                            padding()
                            ProgressView()
                        }
                        case .FAILURE(let error):
                        ZStack(alignment: .bottom) {
                            padding()
                            Text("error fetching quotes: \(error.localizedDescription)")
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(12)
                        }
                        default:
                            EmptyView()
                    }
                    
                    Button {
                        Task {
                            await viewModel.getData(for: show)
                        }
                    } label: {
                        Text("get quote")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(12)
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )
                    }
                }
                .padding()
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
    QuoteView(
        show:"Breaking Bad"
    )
        .preferredColorScheme(.dark)
}
