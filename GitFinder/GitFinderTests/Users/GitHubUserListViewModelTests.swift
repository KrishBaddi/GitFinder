//
//  GitHubUserListViewModelTests.swift
//  GitFinderTests
//
//  Created by Ramkrishna Baddi on 08/04/2023.
//

import XCTest
@testable import GitFinder

class GitHubUserListViewModelTests: XCTestCase {
    
    var testViewModel: GitHubUserListViewModel!
    
    override func setUp() {
        super.setUp()
        testViewModel = GitHubUserListViewModel()
    }
    
    override func tearDown() {
        testViewModel = nil
        super.tearDown()
    }
    
    func testFetchGitHubUsers() {
        // Given
        let mockAPIManager = MockGitHubAPIManager()
        mockAPIManager.mockGitHubUsers = [user]
        
        let testViewModel = GitHubUserListViewModel(apiManager: mockAPIManager)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch GitHub users")
        
        Task {
            do {
                try await testViewModel.fetchGitHubUsers()
                
                // Then
                XCTAssertNotNil(testViewModel.getGithubUsers(), "Users should not be nil")
                XCTAssertGreaterThan(testViewModel.getGithubUsers().count, 0, "Users count should be greater than 0")
                expectation.fulfill()
                
                // Wait for the expectation to be fulfilled with a timeout
                wait(for: [expectation], timeout: 10.0)
            } catch {
                XCTFail("Failed to fetch GitHub users: \(error.localizedDescription)")
            }
        }
    }
}
