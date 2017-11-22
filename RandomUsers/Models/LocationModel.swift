//
//  LocationModel.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/22/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation

struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: Int
}
