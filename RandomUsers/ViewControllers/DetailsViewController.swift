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
    
    @IBOutlet weak var mainUserInfoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firsName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var userData: ResultsModel?
    var isMale: Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.register(UINib(nibName:"\(UserDetailsTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "UserDetailsTableViewCell")
        
        titleLabel.text = userData?.name.title.capitalized
        firsName.text = userData?.name.first.capitalized
        lastName.text = userData?.name.last.capitalized

        guard let image = userData?.picture.large else {return}
        userImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder"))
        userImage.makeImageCircle()
        
        isMale = userData?.gender == "male" ? true : false
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 25))
        view.backgroundColor = isMale ? UIColor().maleBackground() : UIColor().femaleBackground()
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 25))
        
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .gender:
                label.text = "Gender"
            case .city:
                label.text = "City"
            case .street:
                label.text = "Street"
            case .email:
                label.text = "Email"
            case .phone:
                label.text = "Phone"
            }
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsTableViewCell") as? UserDetailsTableViewCell else {
            return UITableViewCell()}
        
        guard let gender = userData?.gender,
            let city = userData?.location.city,
            let street = userData?.location.street,
            let phone = userData?.phone,
            let email = userData?.email else {return UITableViewCell()}

        if let tableSection = TableSection(rawValue: indexPath.section) {
            switch tableSection {
            case .gender:
                cell.populate(userInfo: gender)
            case .city:
                cell.populate(userInfo: city)
            case .street:
                cell.populate(userInfo: street)
            case .phone:
                cell.populate(userInfo: phone)
                cell.userInfo.isUserInteractionEnabled = true
            case .email:
                cell.populate(userInfo: email)
                cell.userInfo.isUserInteractionEnabled = true
            }
        }
        return cell
    }
}
