//
//  RemoveReviewRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import Alamofire

protocol RemoveReviewRequestFactory {
    func getRemoveReview(idComment: Int, completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}
