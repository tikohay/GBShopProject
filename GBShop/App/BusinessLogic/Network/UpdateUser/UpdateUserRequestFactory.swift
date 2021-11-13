//
//  UpdateUser.swift
//  GBShop
//
//  Created by Karahanyan Levon on 28.08.2021.
//

import Alamofire

protocol UpdateUserRequestFactory {
    func updateUser(updateUserData: UserData, completionHandler: @escaping (AFDataResponse<UpdateUserResult>) -> Void)
}
