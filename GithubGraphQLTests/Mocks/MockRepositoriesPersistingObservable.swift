//
//  MockRepositoriesPersistingObservable.swift
//  GithubGraphQLTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

import Combine
@testable import GithubGraphQL

final class MockRepositoriesPersistingObservable: RepositoriesPersistingObservable {
    
    var repositoriesPublishers: CurrentValueSubject<RepositorySearchResult?, Never> = .init(nil)
    var repositoriesSearchResult: RepositorySearchResult? = nil
    
    var repositoriesErrorPublisher: PassthroughSubject<Error?, Never> = .init()
    var repositoriesErrorResult: Error? = nil
    
    func search(phrase: String, refresh: Bool) {
        repositoriesErrorPublisher.send(repositoriesErrorResult)
        repositoriesPublishers.send(repositoriesSearchResult)
    }
}
