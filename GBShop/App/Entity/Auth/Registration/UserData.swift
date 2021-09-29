//
//  RegistrationData.swift
//  GBShop
//
//  Created by Karahanyan Levon on 28.08.2021.
//

import Foundation

struct UserData {
    let id : Int
    let username: String
    let password: String
    let email: String
    let gender: Gender.RawValue
    let creditCard: String
    let bio: String
}
