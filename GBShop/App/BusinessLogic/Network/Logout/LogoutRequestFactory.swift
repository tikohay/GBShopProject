//
//  LogoutRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 28.08.2021.
//

import Alamofire

protocol LogoutRequestFactory {
    func logout(id: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
