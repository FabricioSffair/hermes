@testable import GithubGraphQL
import XCTest

class GithubGraphQLTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
      let mockedResponse = SearchRepositoriesQuery.Data(search: .init(
        pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
        edges: makeEdges(count: 3)
      ))
//      let viewModel = ViewModel(client: MockGraphQLClient<SearchRepositoriesQuery>(response: mockedResponse))

      /* add assertions to validate view model state after making requests */
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
