//
//  APIManagers.swift
//  GitFinder
//
//  Created by Ramkrishna Baddi on 08/04/2023.
//

import Foundation

protocol GitHubAPIManagerProtocol {
    func fetchGitHubObjects<T: Codable>(modelType: T.Type, pageSize: Int) async throws -> [T]?
}

class GitHubAPIManager: GitHubAPIManagerProtocol {
    
    let baseURL = "https://api.github.com"
    var currentPage = 1
    var isFetching = false
    
    // Fetch GitHub users with pagination and dynamically determine page size
    func fetchGitHubObjects<T: Codable>(modelType: T.Type, pageSize: Int) async throws -> [T]? {
        guard !isFetching else { return nil }
        isFetching = true
        
        // Determine page size dynamically based on current page number
        let pageSize = pageSize + (currentPage - 1) * 10
        
        // Create URL components for API request
        var components = URLComponents(string: "\(baseURL)/\(String(describing: T.self))")
        components?.queryItems = [
            URLQueryItem(name: "per_page", value: "\(pageSize)"),
            URLQueryItem(name: "page", value: "\(currentPage)")
        ]
        
        guard let url = components?.url else {
            print("Failed to create URL for GitHub objects API")
            isFetching = false
            throw NSError(domain: "com.example.GitHubAPIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create URL for GitHub objects API"])
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let objects = try decoder.decode([T].self, from: data)
            
            // Increment current page number for next pagination
            currentPage += 1
            isFetching = false
            
            return objects
            
        } catch {
            print("Failed to fetch GitHub objects: \(error.localizedDescription)")
            isFetching = false
            throw error
        }
    }
}
