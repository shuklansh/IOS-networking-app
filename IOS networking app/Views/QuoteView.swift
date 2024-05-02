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
    @State var showCharacterDetails = false
    let show: String
    var body: some View {
        NavigationStack {
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                
                LazyVStack {
                    VStack {
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
                            
                            NavigationLink {
                                CharacterView(
                                    show: show,
                                    character: data.character                                    )
                            } label : {
                                ZStack(alignment: .bottom) {
                                    AsyncImage(url: data.character.images.first) { phase in
                                        if let image = phase.image  {
                                            image
                                                .resizable()
                                                .scaledToFit()
                                        } else if phase.error != nil {
                                            Image(systemName: "exclamationmark.triangle")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                            // the error here is "cancelled" on any view that wasn't visible at app launch
                                        } else {
                                            ProgressView()
                                        }
                                    }
//                                AsyncImage(url: imageLink)  {
//                                    image in image.resizable()
//                                        .scaledToFit()
//                                } placeholder: {
//                                    ProgressView()
//                                }
                                    Text(data.character.name)
                                        .frame(maxWidth: .infinity)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                        .background(.ultraThinMaterial)
                                }
                                .cornerRadius(24)
                                .onTapGesture {
                                    // show screen
                                    showCharacterDetails.toggle()
                                }
                            }
//                                .sheet(isPresented: $showCharacterDetails, content: {
//                                    CharacterView(
//                                        show: show,
//                                        character: data.character
//                                    )
//                                })
                            
                        case .NOT_STARTED:
                            EmptyView()
                        case .FAILURE(let error):
                            ZStack(alignment: .bottom) {
                                Text("error fetching quotes: \(error.localizedDescription)")
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(12)
                            }
                        default:
                            ZStack(alignment: .bottom) {
                                ProgressView()
                            }
                            
                        }
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
            .navigationTitle("")
            .ignoresSafeArea()
        }
    }
}

#Preview {
    QuoteView(
        show: Constants.bcsName
    )
        .preferredColorScheme(.dark)
}
