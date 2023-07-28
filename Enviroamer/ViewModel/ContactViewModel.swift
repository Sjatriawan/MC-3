//
//  ContactViewModel.swift
//  Enviroamer
//
//  Created by tiyas aria on 22/07/23.
//

import Foundation
import UIKit

class ContactViewModel {
    func openAppWith(urlScheme: String) {
        if let url = URL(string: urlScheme) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("App not installed.")
            }
        }
    }
    
    func openInstagram(url : String?) {
        if let instagramURL = url, !instagramURL.isEmpty {
            openAppWith(urlScheme: instagramURL)
        } else {
            showAlert(message: "Instagram link is not available.")
        }
    }
    
    func openSafari(url : String?) {
        if let safariURL = url, !safariURL.isEmpty {
            openAppWith(urlScheme: safariURL)
        } else {
            showAlert(message: "Safari link is not available.")
        }
    }
    
    func openEmailApp(url : String?) {
        if let email = url, !email.isEmpty {
            openAppWith(urlScheme: "mailto:\(email)")
        } else {
            showAlert(message: "Email is not available.")
        }
    }
    
    func openPhoneApp(url : String?) {
        if let phoneNumber = url, !phoneNumber.isEmpty {
            openAppWith(urlScheme: "tel:\(phoneNumber)")
        } else {
            showAlert(message: "Phone number is not available.")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
