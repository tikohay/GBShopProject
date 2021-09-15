//
//  AllReviewsResult.swift
//  GBShop
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import Foundation

struct AllReviewsResult: Codable {
    let idReview: Int
    let idProduct: Int
    let text: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case idReview = "id_review"
        case idProduct = "id_product"
        case text = "text"
        case user = "created_by"
    }
}
