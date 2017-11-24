//
//  UserDetailsTableViewCell.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/24/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var userInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func populate(userInfo: String) {
        self.userInfo.text = userInfo
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
