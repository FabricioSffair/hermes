# Peek iOS Coding Challenge

## View
The app uses SwiftUI due to the fact that it's easy to create reusable components for scalability, also small apps can be built in a fast and simple way, taking this as an advantage for the time management to fit in the 4 hours. In the current application we have HomeView that uses a ViewModel from HomeViewModelObservable protocol to build the view accordingly and make the View layer without any business logic to fit in MVVM architecture. ViewBuilder for button to load again when an issue happens was created and a RepositoryCell so it can be reused. 

The app takes advantages of using viewModifiers to create refreshable list for iOS 15+ natively and due to lack of time a button is added on NavigationBar for iOS14

## ViewModel
ViewModel maintains the business logic responsibility and calls the Repository layer to retrieve data using the GraphQL Client.
This layer uses Combine for a reactive approach when a new data comes or an error is received, so the view can be refreshed and the correct components be displayed.
A HomeViewModelDependencyInjectable is required with a repository to instantiate the HomeViewModel, this way we can mock and easily inject everything to the ViewModel, making it easy to test.

## Repository
A layer to fetch the data from client or local. This layer was created to remove the logic of fetching data and checking it results. The reason to create this is to make the app even more scalable for a possible persistence layer, by having a localPersisting protocol where methods to cache the results in case the user loses network access.

## Unit tests
As a matter of time, only a small portion of the app contains unit tests, which is the HomeViewModel. There are currently two tests, one for search successful and another one for search error. Additional tests such as checking if loadMore is necessary and the refresh can be easily implemented as well as testing the repository layer.

## Nexts steps
If provided more time, next steps would be:
1. Implement a CI with github actions to make sure future changes don't break the app; 
2. Implemet unit tests to every layer of the app;
3. Add local persisting layer to cache results;
4. Add a navigation or webview to open the repository;
