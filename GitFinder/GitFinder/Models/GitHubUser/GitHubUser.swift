//
//  GitHubUser.swift
//  GitFinder
//
//  Created by Ramkrishna Baddi on 08/04/2023.
//

import Foundation

public struct GitHubUser: Codable {
    let login: String
    let id: Int
    let nodeId: String?
    let avatarUrl: URL
    let gravatarId: String?
    let url: URL?
    let htmlUrl: URL?
    let followersUrl: URL?
    let followingUrl: URL?
    let type: String?
    let siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case type
        case siteAdmin = "site_admin"
    }
    
    public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          login = try container.decode(String.self, forKey: .login)
          id = try container.decode(Int.self, forKey: .id)
          nodeId = try container.decodeIfPresent(String.self, forKey: .nodeId)
          avatarUrl = try container.decode(URL.self, forKey: .avatarUrl)
          gravatarId = try container.decodeIfPresent(String.self, forKey: .gravatarId)
          url = try container.decodeIfPresent(URL.self, forKey: .url)
          htmlUrl = try container.decodeIfPresent(URL.self, forKey: .htmlUrl)
          followersUrl = try container.decodeIfPresent(URL.self, forKey: .followersUrl)
        followingUrl = try {
            let urlString = try container.decodeIfPresent(String.self, forKey: .followingUrl)
            return URL(string: urlString ?? "")
        }()
          type = try container.decodeIfPresent(String.self, forKey: .type)
          siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin)
      }

}



