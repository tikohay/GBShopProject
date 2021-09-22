//
//  PayBasketRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 22.09.2021.
//

import Alamofire

protocol PayBasketRequestFactory {
    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
}
