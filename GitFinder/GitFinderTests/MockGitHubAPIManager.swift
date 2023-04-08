//
//  MockGitHubAPIManager.swift
//  GitFinderTests
//
//  Created by Ramkrishna Baddi on 08/04/2023.
//

@testable import GitFinder
import Foundation

// Mocked API manager class for testing
class MockGitHubAPIManager: GitHubAPIManagerProtocol {
    
    var mockGitHubUsers: [GitHubUser]?
    var mockError: Error?
    
    func fetchGitHubObjects<T>(modelType: T.Type, pageSize: Int) async throws -> [T]? where T : Decodable, T : Encodable {
        if let users = mockGitHubUsers as? [T] {
            return users
        } else if let error = mockError {
            throw error
        } else {
            return nil
        }
    }
}
