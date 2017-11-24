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
    
    var httpRequester: HttpRequester?
    var userData: ResultsModel?
    var array: [ResultsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
        configTableView()
        requestData()
    }
    
    internal func requestData() {
        httpRequester?.get(from: Constansts.APIURL)
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

// MARK: - HttpRequesterDelegate
extension UsersViewController: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseModel.self, from: data)
            print("Response: \(response)")
            if array.count == 0 {
                array = response.results
            } else {
                array.append(contentsOf: response.results)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("ERROR: Can't convert data from JSON")
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func didGetFailed(with error: String) {
    }
}
