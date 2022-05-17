//
//  HomeViewModelTests.swift
//  GithubGraphQLTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-16.
//  Copyright © 2022 test. All rights reserved.
//

@testable import GithubGraphQL

import Combine
import XCTest

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    var repository: MockRepositoriesPersistingObservable!
    var subscribers: Set<AnyCancellable>!
    
    override func setUp() {
        subscribers = []
        repository = MockRepositoriesPersistingObservable()
        let dependencies = MockHomeDependencyInjectable(repo: repository)
        sut = HomeViewModel(dependencies: dependencies)
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        subscribers = nil
    }
    
    func testDefaultGraphQLSearch() {
        let mockedResults = RepositorySearchResult.mockResults(15)
        repository.repositoriesSearchResult = mockedResults
        repository.repositoriesErrorPublisher.sink {
            XCTAssertNil($0)
        }
        .store(in: &subscribers)
        repository.repositoriesPublishers.collect(2).sink { result in
            guard let searchResult = result.last else { return }
            XCTAssertEqual(searchResult, mockedResults)
        }
        .store(in: &subscribers)
        sut.loadMoreIfNeeded(0)
    }
    
    func testErrorSearch() {
        let errorResult = "Unable to fetch data"
        repository.repositoriesErrorResult = errorResult
        repository.repositoriesErrorPublisher.sink { error in
            XCTAssertEqual(error?.localizedDescription, errorResult.localizedDescription)
        }
        .store(in: &subscribers)
        repository.repositoriesPublishers.sink {
            XCTAssertNil($0)
        }
        .store(in: &subscribers)
        sut.loadMoreIfNeeded(0)
    }
    
}

extension String: Error {}

extension RepositoryDetails: Equatable {
    
    public static func == (lhs: RepositoryDetails, rhs: RepositoryDetails) -> Bool {
        lhs.name == rhs.name &&
        lhs.url == rhs.url
    }
}
extension RepositorySearchResult: Equatable {
    
    public static func == (lhs: RepositorySearchResult, rhs: RepositorySearchResult) -> Bool {
        lhs.repos == rhs.repos
    }
    
    static func mockResults(_ numberOfResults: Int) -> RepositorySearchResult {
        let repos: [RepositoryDetails] = (0..<numberOfResults)
            .reduce(into: []) { result, index in
                result.append(
                    .init(
                        name: "repo\(index)",
                        url: "https://github.com/peek/repo\(index)",
                        owner: RepositoryDetails.Owner.makeOrganization(login: "Peek Travel",
                                                                        avatarUrl: "https://d2z5w7rcu7bmie.cloudfront.net/assets/images/logo.png"),
                        stargazers: .init(totalCount: 100)
                    )
                )
            }
        
        return .init(
            pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
            repos: repos
        )
    }
    
}
