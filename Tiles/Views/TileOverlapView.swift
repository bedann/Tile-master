//
//  TileOverlapView.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI

struct TileOverlapView: View {
    
    @EnvironmentObject var model:ViewModel
    
    var body: some View {
        VStack{
            ZStack(alignment: .topLeading){
                ForEach(model.tiles.reversed()){ tile in
                    Rectangle()
                        .fill(Color.random)
                        .frame(width: tile.width.asFeet.relativeValue, height: tile.length.asFeet.relativeValue, alignment: .center)
                        .overlay(
                            Text(tile.width.withSymbol),
                            alignment: .bottom
                        )
                    .overlay(
                        Text(tile.length.withSymbol),
                        alignment: .trailing
                    )
                }
            }
        }
    }
}

struct TileOverlapView_Previews: PreviewProvider {
    static var previews: some View {
        TileOverlapView()
            .environmentObject(ViewModel())
    }
}
