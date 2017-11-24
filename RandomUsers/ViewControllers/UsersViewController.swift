//
//  UsersViewController.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/22/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    var httpRequester: HttpRequester?
    var userData: ResultsModel?
    var array: [ResultsModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
        

        self.tableView.register(UINib(nibName:"\(UserTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        
        let url = "https://randomuser.me/api/?results=5"
        httpRequester?.get(from: url)
    }
    
    func showNextVC(userData: ResultsModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "\(DetailsViewController.self)") as? DetailsViewController else {return}
        detailsVC.userData = userData
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

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

        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = array[indexPath.row]
        showNextVC(userData: currentUser)
    }
}

extension UsersViewController: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseModel.self, from: data)
            print("Response: \(response)")
            array = response.results
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
    
    func didPostSuccess(with data: Data) {
        
    }
    
    func didPostFailed(with error: String) {
        
    }
    
    
}
