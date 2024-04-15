//
//  CharacterView.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 15/04/24.
//

import SwiftUI

struct CharacterView: View {
    @Environment(\.dismiss) var dismissCurrentScreen
    let show: String
    let character: Character
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                    Image(show.lowerNoSpaces)
                        .resizable()
                        .scaledToFit()
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .onTapGesture {
                                    dismissCurrentScreen()
                                }
                                .padding(15)
                            Spacer()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(width: geo.size.width)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(character.images, id:\.self) { imageLink in
                                    AsyncImage(url: imageLink, content: {
                                        image in image
                                            .resizable()
                                            .scaledToFill()
                                    }, placeholder: { ProgressView() })
                                    .frame(
                                        width: geo.size.width * 0.8,
                                        height: geo.size.height * 0.7
                                    )
                                    .cornerRadius(24)
                                    .padding(.top, 60)
                                }
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.largeTitle)
                            Text(character.birthday)
                            ForEach(character.aliases, id:\.self) { name in
                                Text(name)
                            }
                        }
                }
            }.ignoresSafeArea()
        }
    }
}
