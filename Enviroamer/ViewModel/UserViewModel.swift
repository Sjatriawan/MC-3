//
//  UserViewModel.swift
//  Enviroamer
//
//  Created by tiyas aria on 27/07/23.
//

import SwiftUI

class UserViewModel : ObservableObject {
    @AppStorage("user_signin") var currentUserSignIn : Bool = false
}
