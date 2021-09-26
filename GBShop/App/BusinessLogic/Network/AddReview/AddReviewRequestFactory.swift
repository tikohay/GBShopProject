//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import Alamofire

protocol AddReviewRequestFactory {
    func getAddReview(idUser: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
}
