//
//  UserService.swift
//  RandomUsers
//
//  Created by Cookie on 24.11.17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation

protocol UserServiceDelegate {
    func didRegisterSuccess()
    func didRegisterFailure(withError: String)
}

class UserService {
    var delegate: UserServiceDelegate?
    var httpRequester: HttpRequester? = HttpRequester()
    var array: [ResultsModel] = []
    
    init() {
        httpRequester?.delegate = self
    }
    
    func requestUsers() {
        httpRequester?.get(from: Constansts.APIURL)
    }
}

extension UserService: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseModel.self, from: data)
            if array.count == 0 {
                array = response.results
            } else {
                array.append(contentsOf: response.results)
            }
            
            delegate?.didRegisterSuccess()
        } catch {
            print("ERROR: Can't convert data from JSON")
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func didGetFailed(with error: String) {
        self.delegate?.didRegisterFailure(withError: error)
    }
}
