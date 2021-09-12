//
//  ProductResult.swift
//  GBShop
//
//  Created by Karahanyan Levon on 03.09.2021.
//

import Foundation

struct ProductResult: Codable {
    let result: Int
    let name: String
    let description: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case name = "product_name"
        case description = "product_description"
        case price = "product_price"
    }
}
