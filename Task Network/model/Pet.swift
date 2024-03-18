//
//  Pet.swift
//  Task Network
//
//  Created by Noura Aldaihani on 05/03/2024.
//

import Foundation
import Alamofire

struct Pet: Codable {
    let id: Int?
    let name: String
    let adopted: Bool
    let image: String
    let age: Int
    let gender: String
}
