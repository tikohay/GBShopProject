//
//  ConfigCell.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import Foundation

protocol ConfigCell {
    associatedtype T
    
    static var reuseId: String { get }
    func configCell(with value: T)
}
