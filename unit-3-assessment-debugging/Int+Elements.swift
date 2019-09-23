//
//  Int+Elements.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

extension Int {
    func getStringForThumbnailImage() -> String {
        if self < 10 {
            return "00\(self)"
        } else if self < 100 {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
}
