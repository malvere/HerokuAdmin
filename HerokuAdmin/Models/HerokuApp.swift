//
//  App.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//
// JSON model for heroku app list API response
import Foundation

struct HerokuApp: Codable, Hashable {
    let name: String
    let id: String
}
