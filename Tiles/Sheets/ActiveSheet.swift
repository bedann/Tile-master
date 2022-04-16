//
//  ActiveSheet.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case overlap, newTile;
    
    var id:UUID{
        return UUID()
    }
}
