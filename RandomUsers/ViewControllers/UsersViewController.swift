//
//  UsersViewController.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/22/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var userData: ResultsModel?
    var array: [ResultsModel] = []
    
    var userService: UserService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService.delegate = self
        configTableView()
        requestData()
    }
    
    func requestData() {
        userService.requestUsers()
    }
    
    func showNextVC(userData: ResultsModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "\(DetailsViewController.self)") as? DetailsViewController else {return}
        detailsVC.userData = userData
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // private methods
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName:"\(UserTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(UserTableViewCell.self)")
    }
}

extension UsersViewController: UserServiceDelegate {
    func didRegisterSuccess() {
        self.array = userService.array
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didRegisterFailure(withError: String) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: withError)
        }
    }
}

