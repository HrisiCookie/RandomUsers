//
//  UsersViewController+UITableViewDelegate.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/24/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation
import UIKit

extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count: \(array.count)")
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "\(UserTableViewCell.self)", for: indexPath) as? UserTableViewCell
        guard let cell = userCell else { return UITableViewCell() }
        
        let first = array[indexPath.row].name.first.uppercased()
        let last = array[indexPath.row].name.last.uppercased()
        let image = array[indexPath.row].picture.thumbnail
        let city = array[indexPath.row].location.city.capitalized
        
        cell.populate(firstName: first, lastName: last, image: image, city: city)
        
        if indexPath.row == self.array.count - 1 {
            if array.count < 100 {
                requestData()
            }
        }
        
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = array[indexPath.row]
        showNextVC(userData: currentUser)
    }
}
