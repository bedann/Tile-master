//
//  Extensions.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI


extension Color{
    
    static var random:Color{
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
    }
}
