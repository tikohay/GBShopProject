//
//  Registration.swift
//  GBShop
//
//  Created by Karahanyan Levon on 28.08.2021.
//

import Foundation

struct RegistrationResult: Codable {
    let result: Int
    let userMessage: String
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case userMessage = "user_message"
        case errorMessage = "error_message"
    }
}
