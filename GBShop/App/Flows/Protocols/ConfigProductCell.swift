//
//  ConfigCell.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import Foundation

protocol ConfigProductCell {
    static var reuseId: String { get }
    func configeCell(with product: Any)
}
