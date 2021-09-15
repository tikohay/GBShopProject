//
//  CatalogRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 03.09.2021.
//

import Alamofire

protocol CatalogRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[CatalogProductResult]>) -> Void)
}
