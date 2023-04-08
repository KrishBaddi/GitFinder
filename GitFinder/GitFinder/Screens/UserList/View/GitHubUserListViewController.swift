//
//  GitHubUserListViewController.swift
//  GitFinder
//
//  Created by Ramkrishna Baddi on 08/04/2023.
//

import UIKit

class GitHubUserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private let viewModel = GitHubUserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set up search bar
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search by username or note"
        
        // Fetch initial page of GitHub users
        Task {
            try await loadData()
        }
    }
    
    func loadData() async throws {
        do {
            try await viewModel.fetchGitHubUsers()
            tableView.reloadData()
        } catch {
            throw error
        }
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitHubUserCell", for: indexPath) as! GitHubUserCell
        let user = viewModel.user(at: indexPath.row)
        
        // Configure cell with GitHub user data
        //cell.configure(with: user)
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectUser(at: indexPath.row)
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterGitHubUsers(with: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filterGitHubUsers(with: "")
        tableView.reloadData()
    }
    
    // MARK: - Other methods for handling note icon, spinner, and other interactions
    
}

// Custom

