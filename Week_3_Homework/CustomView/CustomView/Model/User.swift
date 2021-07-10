//
//  User.swift
//  CustomView
//
//  Created by Fahreddin Gölcük on 10.07.2021.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let company: Company
}

struct Company: Decodable {
    let name: String
}
