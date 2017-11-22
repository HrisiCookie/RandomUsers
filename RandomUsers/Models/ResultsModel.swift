//
//  ResultsModel.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/22/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation

struct ResultsModel: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let cell: String
    let id: Id
    let picture: Picture
}
