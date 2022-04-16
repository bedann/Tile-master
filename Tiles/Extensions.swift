//
//  Extensions.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI


extension Color{
    
    static var random:Color{
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), opacity: 1)
    }
    
}

extension Array {
    func and(o: Element) -> [Element] {
        return self + [o]
    }
}
