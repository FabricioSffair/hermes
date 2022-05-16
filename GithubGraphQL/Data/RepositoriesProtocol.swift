//
//  RepositoriesProtocol.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

import Combine

protocol RepositoriesPersistingObservable: RepositoriesFetching {
    var client: GraphQLClient { get }
    var repositoriesPublishers: CurrentValueSubject<RepositorySearchResult?, Never> { get }
    var repositoriesErrorPublisher: PassthroughSubject<Error, Never> { get }
}

protocol RepositoriesFetching {
    func search(phrase: String)
}
