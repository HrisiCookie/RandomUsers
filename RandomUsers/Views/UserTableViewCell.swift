//
//  UserTableViewCell.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/23/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.makeImageCircle()
    }

    func populate(firstName: String, lastName: String, image: String, city: String) {
        self.firstNameLabel.text = firstName
        self.lastNameLabel.text = lastName
        self.cityLabel.text = city
        self.userImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
