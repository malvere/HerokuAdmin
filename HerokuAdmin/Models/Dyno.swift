//
//  AppSettings.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 07.12.2021.
//
//JSON model for dyno info API call
import Foundation

struct Dyno: Codable, Hashable {
    let app: HerokuApp
    let type: String
    let quantity: Int
    let id: String
}
