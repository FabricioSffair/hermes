//
//  HomeView.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI

protocol HomeViewModelObservable: ObservableObject {
    func loadMore()
    var repos: [RepositoryDetails] { get }
    var error: String? { get }
}

struct HomeView<ViewModel: HomeViewModelObservable>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<viewModel.repos.count, id: \.self) { index in
                        Text(viewModel.repos[index].name)
                            .onAppear {
                                if index == viewModel.repos.count - Constants.HomeView.loadMoreIndex {
                                    viewModel.loadMore()
                                }
                            }
                        
                    }
                    if let error = viewModel.error {
                        tryAgainButton(with: error)
                    }
                }
                .navigationTitle(Strings.HomeView.title)
            }
        }
    }
    
    @ViewBuilder
    func tryAgainButton(with text: String) -> some View {
        Button {
            viewModel.loadMore()
        } label: {
            VStack {
                Text(text)
                    .font(Font.system(size: 12))
                Images.HomeView.refreshIcon
                    .font(Font.system(size: 12))
            }
        }
        .padding()
        .frame(height: 44)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
