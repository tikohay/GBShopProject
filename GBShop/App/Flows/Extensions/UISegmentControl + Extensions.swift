//
//  UISegmentControl + Extensions.swift
//  GBShop
//
//  Created by Karahanyan Levon on 25.09.2021.
//

import UIKit

protocol SegmentedControlExtenstionProtocol { }

extension SegmentedControlExtenstionProtocol where Self: UISegmentedControl {
    init(first: String, second: String, third: String) {
        self.init()
        self.insertSegment(withTitle: first, at: 0, animated: true)
        self.insertSegment(withTitle: second, at: 1, animated: true)
        self.insertSegment(withTitle: third, at: 2, animated: true)
        self.selectedSegmentIndex = 0
    }
}

class ExtendedSegmentedControl: UISegmentedControl, SegmentedControlExtenstionProtocol {
    
}
