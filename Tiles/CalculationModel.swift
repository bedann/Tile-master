//
//  CalculationModel.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI

struct CalculationModel: Codable, Identifiable {
    
    var id:String{
        return UUID().uuidString
    }
    
    var name:String = ""
    var length:Unit = .feet(0)
    var width:Unit = .feet(0)
    
    var tile:TileModel
    
    var area:Double{
        return length.asFeet.value * width.asFeet.value
    }
    
    var totalPieces:Double{
        return area/tile.area
    }
    
    var boxes:Double{
        return totalPieces/Double(tile.boxSize)
    }
    
}
