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
    
    func openInstagram(url : String) {
          openAppWith(urlScheme: url)
      }
      
      func openSafari(url : String) {
          openAppWith(urlScheme: url)
      }
      
      func openEmailApp(url : String) {
          openAppWith(urlScheme: url)
      }
      
      func openPhoneApp(url : String) {
          openAppWith(urlScheme:url)
      }
}
