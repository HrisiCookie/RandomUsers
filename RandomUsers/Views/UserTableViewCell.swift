//
//  UserTableViewCell.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/23/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(firstName: String, lastName: String) {
        self.firstName.text = firstName
        self.lastName.text = lastName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
