//
//  HomeView.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI

protocol HomeViewModelObservable: ObservableObject {
    func loadMoreIfNeeded(_ index: Int)
    func refresh()
    var isLoading: Bool { get }
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
                        let repo = viewModel.repos[index]
                        RepositoryCell(
                            name: repo.name,
                            url: repo.url,
                            imageURL: repo.owner.avatarUrl,
                            owner: repo.owner.login,
                            stargazer: repo.stargazers.totalCount
                        )
                            .onAppear {
                                viewModel.loadMoreIfNeeded(index)
                            }
                    }
                    if let error = viewModel.error {
                        tryAgainButton(with: error)
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
                .refreshableLists {
                    viewModel.refresh()
                }
                .navigationTitle(Strings.HomeView.title)
            }
        }
    }
    
    @ViewBuilder
    func tryAgainButton(with text: String) -> some View {
        Button {
            viewModel.loadMoreIfNeeded(viewModel.repos.count)
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
