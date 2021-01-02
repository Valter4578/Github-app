//
//  User.swift
//  Github
//
//  Created by Максим Алексеев on 02.01.2021.
//

import Foundation

struct User: Codable {
    let name: String
    let bio: String
    let twitterUsername: String
    let followersCount: Int
    let followingCount: Int
}
