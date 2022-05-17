//
//  RepositoryCell.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-17.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI
import Kingfisher

struct RepositoryCell: View {
    
    enum Dimensions {
        
        static let imageHeight = 30.0
        static let minScaleFactor = 0.8
        static let stargazerWidth = 44.0
        static let lineLimit = 1
    }
    
    @State var name: String
    @State var url: String
    @State var imageURL: String
    @State var owner: String
    @State var stargazer: Int
    
    var body: some View {
        HStack {
            if let url = URL(string: imageURL) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(height: Dimensions.imageHeight)
            } else {
                Images.HomeView.placeholder
            }
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .autoShrink()
                Text("Author: \(owner)")
                    .font(.footnote)
                    .autoShrink()
            }
            .padding(.horizontal)
            Spacer()
            VStack {
                Images.HomeView.stargazerIcon
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(stargazer)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .autoShrink()
            }
            .frame(width: Dimensions.stargazerWidth)
        }
    }
}

struct RepositoryCell_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCell(name: "GraphQL Test", url: "", imageURL: "", owner: "Peek", stargazer: 100)
    }
}
	
