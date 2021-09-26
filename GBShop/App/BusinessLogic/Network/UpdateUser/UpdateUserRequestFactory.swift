//
//  UpdateUser.swift
//  GBShop
//
//  Created by Karahanyan Levon on 28.08.2021.
//

import Foundation
import Alamofire

protocol UpdateUserRequestFactory {
    func updateUser(updateUserData: UpdateUserData, completionHandler: @escaping (AFDataResponse<UpdateUserResult>) -> Void)
}
