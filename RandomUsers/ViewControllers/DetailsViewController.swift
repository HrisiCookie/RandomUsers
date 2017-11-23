//
//  DetailsViewController.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/23/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var firsName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var userData: ResultsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firsName.text = userData?.name.first
        lastName.text = userData?.name.last
        phoneNumber.text = userData?.phone
        email.text = userData?.email
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
