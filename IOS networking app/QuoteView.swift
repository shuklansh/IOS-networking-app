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
//        GeometryReader { geo in
            // used to adapt app to screen size
            ZStack {
                Image(show.lowercased().filter { $0 != " " })
                    .resizable()
                    
                LazyVStack {
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
                            
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: data.character.images.first)  {
                                    image in image.resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(data.character.name)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.ultraThinMaterial)
                            }
                            .cornerRadius(24)
                            
                        case .IN_PROGRESS:
                        ZStack(alignment: .bottom) {
                            ProgressView()
                        }
                        case .FAILURE(let error):
                        ZStack(alignment: .bottom) {
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
                    }
                }
                .padding()
            }
            .ignoresSafeArea()
        }
//    }
}

#Preview {
    QuoteView(
        show:"Breaking Bad"
    )
        .preferredColorScheme(.dark)
}
