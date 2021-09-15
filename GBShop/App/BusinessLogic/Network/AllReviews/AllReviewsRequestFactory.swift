//
//  AllReviewsRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import Alamofire

protocol AllReviewsRequestFactory {
    func getAllReviews(productId: Int, completionHandler: @escaping (AFDataResponse<[AllReviewsResult]>) -> Void)
}
