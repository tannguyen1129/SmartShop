//
//  String+Extensions.swift
//  SmartShop
//
//  Created by umtlab03im07 on 19/3/25.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
