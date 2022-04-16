//
//  TileModel.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI

struct TileModel: Codable, Identifiable {
    var id:String{
        return UUID().uuidString
    }
    
    var length:Unit
    var width:Unit
    
    var boxSize:Int
    
    var area:Double{
        return length.asFeet.value * width.asFeet.value
    }
}
