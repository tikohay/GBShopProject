//
//  RemoveProductFromBasketRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 17.09.2021.
//

import Alamofire

protocol DeleteProductFromBasketRequestFactory {
    func deleteProductFromBasket(productId: Int, completionHandler: @escaping (AFDataResponse<DeleteProductFromBasketResult>) -> Void)
}
