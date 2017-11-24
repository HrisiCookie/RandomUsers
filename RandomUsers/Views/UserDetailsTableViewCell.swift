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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(userInfo: String) {
        self.userInfo.text = userInfo
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func onClick(_ sender: Any) {
    }
}
