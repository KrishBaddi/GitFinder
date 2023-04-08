//
//  GitHubUserListViewModel.swift
//  GitFinder
//
//  Created by Ramkrishna Baddi on 08/04/2023.
//

import Foundation
import UIKit

// View model for managing GitHub user data and interactions
class GitHubUserListViewModel {
    
    private var apiManager: GitHubAPIManagerProtocol
    private var githubUsers: [GitHubUser] = []
    private var filteredGitHubUsers: [GitHubUser] = []
    private var isSearching: Bool = false
    private var currentPage = 1
    private var pageSize = 10
    private var isFetching = false
    
    init(apiManager: GitHubAPIManagerProtocol = GitHubAPIManager()) {
        self.apiManager = apiManager
    }
    
    // Fetch GitHub users with pagination and dynamically determined page size
    func fetchGitHubUsers() async throws {
            // Check if already fetching
            guard !isFetching else { return }
            isFetching = true
            
            do {
                // Fetch GitHub users using async/await
                guard let users = try await apiManager.fetchGitHubObjects(modelType: GitHubUser.self, pageSize: pageSize)
                else {
                    // Handle this case
                    return
                }
                
                // Handle fetched GitHub users
                githubUsers.append(contentsOf: users)
                
                // Increment current page number for next pagination
                currentPage += 1
                
                // Reset isFetching flag
                isFetching = false
                
            } catch {
                // Reset isFetching flag in case of error
                isFetching = false
                throw error
            }
        }
    
    // Filter GitHub users based on search text
    func filterGitHubUsers(with searchText: String) {
        // Implement logic for filtering GitHub users based on search text
        // Update filteredGitHubUsers array
    }
    
    // Get number of GitHub users based on search mode
    func numberOfUsers() -> Int {
        return isSearching ? filteredGitHubUsers.count : githubUsers.count
    }
    
    // Get GitHub user at index based on search mode
    func user(at index: Int) -> GitHubUser {
        return isSearching ? filteredGitHubUsers[index] : githubUsers[index]
    }
    
    // Handle selection of a GitHub user
    func didSelectUser(at index: Int) {
        // Implement logic for handling selection of a GitHub user
    }
    
    // Unit testing
    func getGithubUsers() -> [GitHubUser] {
        return githubUsers
    }
    
    // Other methods for managing note icon, spinner, and other interactions
    
}
