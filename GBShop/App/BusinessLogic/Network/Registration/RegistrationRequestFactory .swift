//
//  RegistrationRequestFactory .swift
//  GBShop
//
//  Created by Karahanyan Levon on 28.08.2021.
//

import Foundation
import Alamofire

protocol RegistrationRequestFactory {
    func register(registrationData: RegistrationData, completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
}
