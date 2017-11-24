//
//  DetailsViewController.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/23/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit
import SDWebImage

enum TableSection: Int {
    case gender = 0
    case city = 1
    case street = 2
    case email = 3
    case phone = 4
}

class DetailsViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var mainUserInfoView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var firsName: UILabel!
    @IBOutlet private weak var lastName: UILabel!
    @IBOutlet private weak var userImage: UIImageView!
    
    var userData: ResultsModel?
    var isMale: Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        updateUI()
    }
    
    //private methods
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.register(UINib(nibName:"\(UserDetailsTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(UserDetailsTableViewCell.self)")
        
        tableView.tableFooterView = UIView()
    }
    
    private func updateUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.white

        isMale = userData?.gender == "male" ? true : false

        titleLabel.text = userData?.name.title.capitalized
        firsName.text = userData?.name.first.capitalized
        lastName.text = userData?.name.last.capitalized
        
        guard let image = userData?.picture.large else {return}
        userImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder"))
        userImage.makeImageCircle()
        
        mainUserInfoView.backgroundColor = isMale ? UIColor().maleBackground() : UIColor().femaleBackground()
    }
}


