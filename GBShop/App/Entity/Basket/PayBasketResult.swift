//
//  PayBasketResult.swift
//  GBShop
//
//  Created by Karahanyan Levon on 22.09.2021.
//

import Foundation

struct PayBasketResult: Codable {
    var amount: Int
    var countGoods: Int
    var contents: [ProductResult]
}
