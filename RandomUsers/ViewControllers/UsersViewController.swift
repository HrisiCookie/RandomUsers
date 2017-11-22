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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
        
        let url = "https://randomuser.me/api/"
        httpRequester?.get(from: url)
    }
}

extension UsersViewController: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseModel.self, from: data)
            print("Response!!!: \(response)")
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
