//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Karahanyan Levon on 04.10.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
