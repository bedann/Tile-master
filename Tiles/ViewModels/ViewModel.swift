//
//  ViewModel.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var calculations = [CalculationModel]()
    @Published var tiles = [TileModel]()
    @Published var scrollTile:String? = nil
    
    init(){
        tiles.append(.init(length: .feet(1), width: .feet(1), boxSize: 17))
        tiles.append(.init(length: .inches(16), width: .inches(16), boxSize: 12))
        tiles.append(.init(length: .feet(1), width: .inches(16), boxSize: 15))
        tiles.append(.init(length: .feet(2), width: .feet(2), boxSize: 4))
        tiles.sort { a, b in
            return a.area < b.area
        }
    }
    
}
