//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 03.09.2021.
//

import Alamofire

protocol ProductRequestFactory {
    func getProduct(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
