//
//  HomeViewModel.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

final class Dependencies: HomeDependencyInjectable {

    static let shared: Dependencies = .init()

    var repo: RepositoriesPersistingObservable = Repository()
}

protocol HomeDependencyInjectable {
    var repo: RepositoriesPersistingObservable { get }
}

import Combine
import Foundation

final class HomeViewModel: HomeViewModelObservable {
    
    @Published var repos: [RepositoryDetails] = []
    @Published var error: String?
    
    private var repository: RepositoriesPersistingObservable
    private var subscribers: Set<AnyCancellable> = []
    private var hasMore = true
    
    init(dependencies: HomeDependencyInjectable = Dependencies.shared) {
        self.repository = dependencies.repo
        repository.repositoriesPublishers
            .receive(on: DispatchQueue.main)
            .sink { searchResult in
                guard let result = searchResult else { return }
                self.error = nil
                self.repos += result.repos
                self.hasMore = result.pageInfo.hasNextPage
            }
            .store(in: &subscribers)
        repository.repositoriesErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.error = Strings.HomeView.defaultError
            }
            .store(in: &subscribers)
        loadMore()
    }
    
    func loadMore() {
        guard hasMore else { return }
        repository.search(phrase: Strings.HomeView.searchTerm)
    }
    
}
