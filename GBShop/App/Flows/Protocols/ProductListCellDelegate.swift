//
//  ProductListCellDelegate.swift
//  GBShop
//
//  Created by Karahanyan Levon on 15.10.2021.
//

import Foundation

protocol ProductListCellDelegate {
    func buy(cell: ProductListTableViewCell)
    func delete(cell: ProductListTableViewCell)
}
