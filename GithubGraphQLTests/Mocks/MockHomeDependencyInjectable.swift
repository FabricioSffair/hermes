//
//  MockHomeDependencyInjectable.swift
//  GithubGraphQLTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

@testable import GithubGraphQL

final class MockHomeDependencyInjectable: HomeDependencyInjectable {
    var repo: RepositoriesPersistingObservable
    
    init(repo: RepositoriesPersistingObservable) {
        self.repo = repo
    }
}
