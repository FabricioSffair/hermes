//
//  HomeViewModel.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

import Combine
import Foundation

final class HomeViewModel: HomeViewModelObservable {
    
    @Published var repos: [RepositoryDetails] = []
    @Published var error: String?
    @Published var isLoading = false
    
    private var repository: RepositoriesPersistingObservable
    private var subscribers: Set<AnyCancellable> = []
    private var hasMore = true
    
    init(dependencies: HomeDependencyInjectable = Dependencies.shared) {
        self.repository = dependencies.repo
        repository.repositoriesPublishers
            .receive(on: DispatchQueue.main)
            .sink { searchResult in
                self.isLoading = false
                
                guard let result = searchResult else { return }
                self.error = nil
                self.repos += result.repos
                self.hasMore = result.pageInfo.hasNextPage
            }
            .store(in: &subscribers)
        
        repository.repositoriesErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink { error in
                self.isLoading = false
                self.error = error?.localizedDescription
                guard error == nil else {
                    self.error = Strings.HomeView.defaultError
                    return
                }
            }
            .store(in: &subscribers)
        search()
    }
    
    func loadMoreIfNeeded(_ index: Int) {
        guard hasMore else { return }
        guard index >= repos.count - Constants.HomeView.loadMoreIndex else { return }
        search()
    }
    
    func refresh() {
        repos = []
        search(refresh: true)
    }
    
    func search(refresh: Bool = false) {
        self.isLoading = true
        repository.search(phrase: Strings.HomeView.searchTerm, refresh: refresh)
    }
    
}
