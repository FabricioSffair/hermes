//
//  Dependenies.swift
//  GithubGraphQL
//
//  Created by Fabrício Sperotto Sffair on 2022-05-17.
//  Copyright © 2022 test. All rights reserved.
//

import Foundation

final class Dependencies: HomeDependencyInjectable {

    static let shared: Dependencies = .init()

    var repo: RepositoriesPersistingObservable = Repository()
}

protocol HomeDependencyInjectable {
    var repo: RepositoriesPersistingObservable { get }
}
