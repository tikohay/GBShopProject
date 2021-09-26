//
//  AddProductToBasketRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 17.09.2021.
//

import Alamofire

protocol AddProductToBasketRequestFactory {
    func addProductToBasket(productId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddProductToBasketResult>) -> Void)
}
