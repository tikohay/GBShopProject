//
//  RegistrationRequestFactory .swift
//  GBShop
//
//  Created by Karahanyan Levon on 28.08.2021.
//

import Alamofire

protocol RegistrationRequestFactory {
    func register(registrationData: UserData, completionHandler: @escaping (AFDataResponse<RegistrationResult>) -> Void)
}
