import Apollo
import Combine

final class Repository: RepositoriesPersistingObservable {
    
    var client: GraphQLClient
    var cursor: String?
    
    private(set) var repositoriesPublishers: CurrentValueSubject<RepositorySearchResult?, Never>
    private(set) var repositoriesErrorPublisher: PassthroughSubject<Error?, Never> = .init()
    
    init(client: GraphQLClient = ApolloClient.shared) {
        self.client = client
        repositoriesPublishers = .init(nil)
    }
    
    func search(phrase: String, refresh: Bool = false) {
        var filter: SearchRepositoriesQuery.Filter? = nil
        if refresh {
            cursor = nil
        }
        if let cursor = cursor {
            filter = SearchRepositoriesQuery.Filter.after(Cursor(rawValue: cursor))
        }
        
        self.client.searchRepositories(mentioning: phrase, filter: filter) { response in
            switch response {
            case let .failure(error):
                self.repositoriesErrorPublisher.send(error)
                
            case let .success(results):
                let pageInfo = results.pageInfo
                self.cursor = pageInfo.endCursor
                self.repositoriesErrorPublisher.send(nil)
                self.repositoriesPublishers.send(results)
            }
        }
    }
}
