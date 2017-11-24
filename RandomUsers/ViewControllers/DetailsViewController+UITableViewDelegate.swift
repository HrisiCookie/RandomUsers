//
//  DetailsViewController+UITableViewDelegate.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/24/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

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
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 25))
        label.textColor = isMale ? UIColor().maleBackground() : UIColor().femaleBackground()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserDetailsTableViewCell.self)") as? UserDetailsTableViewCell else {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tableSection = TableSection(rawValue: indexPath.section) {
            switch tableSection {
            case .phone:
                switch indexPath.row {
                case 0:
                    if let phone = userData?.phone {
                        callNumber(phoneNumber: phone)
                    }
                default:
                    break
                }
            case .email:
                switch indexPath.row {
                case 0:
                    if let email = userData?.email {
                        sendEmail(withEmail: email)
                    }
                default:
                    break
                }
            default:
                print("Just pressed")
            }
        }
    }
    
    func callNumber(phoneNumber: String) {
        let result = String(phoneNumber.characters.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil })
        
        let urlString = "tel://\(result)"
        if let phoneCallURL = URL(string: urlString),
            UIApplication.shared.canOpenURL(phoneCallURL) {
            UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        } else {
            self.showAlert(title: Constansts.invalidPhoneNumberTitle, message: Constansts.invalidPhoneNumberMessage)
        }
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension DetailsViewController: MFMailComposeViewControllerDelegate {
    func sendEmail(withEmail email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            self.showAlert(title: Constansts.noEmailTitle, message: Constansts.noEmailMessage)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

