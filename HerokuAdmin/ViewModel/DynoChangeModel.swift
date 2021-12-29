//
//  DynoChange.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 11.12.2021.
//

import Foundation

// Getting dyno information using async function
func fetchJson(appName: String, dyno: Dyno, scale: Int) async {
    let endpoint = "https://api.heroku.com/apps/\(appName)/formation/\(dyno.id)"
    let token = String(decoding: Keychain.load(key: Constants.keychainKey) ?? Data("".utf8), as: UTF8.self).lowercased()
    let headers = [
        "Accept": "application/vnd.heroku+json; version=3",
        "Authorization": "Bearer \(token)"
    ]
    
    guard let url = URL(string: endpoint) else {
        return
    }
    
    // API Request with defined quantity of scaled dynos
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    let quantity = Scale(quantity: scale)
    
    // Packing JSON that will be sent to server
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let jsonData = try? encoder.encode(quantity)
    request.httpMethod = "PATCH"
    request.httpBody = jsonData
    
    // Creating URLSession task with method "POST"
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        guard error == nil else {
            return
        }
        guard data != nil else {
            return
        }
    }
    task.resume()
}

