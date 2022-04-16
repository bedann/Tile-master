//
//  NewTileView.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI

struct NewTileView: View {
    
    @State var length = ""
    @State var width = ""
    @State var boxSize = ""
    @State var lengthUnitIndex:Int = 0
    @State var widthUnitIndex:Int = 0
    @State var lengthUnit:Unit?
    @State var widthUnit:Unit?
    @State var error:String? = nil
    @EnvironmentObject var model:ViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header:Text("Preview")){
                        HStack{
                            Spacer()
                            Rectangle()
                                .fill(Color(.systemBrown))
                                .frame(width: widthUnit?.asFeet.relativeValue ?? 0, height: lengthUnit?.asFeet.relativeValue ?? 0, alignment: .center)
                            Spacer()
                        }
                    }
                    if let error = error {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    Section(header: Text("Tile settings (Max 3 ft)")){
                        HStack{
                            TextField("Length", text: $length)
                                .keyboardType(.numberPad)
                            Picker("Unit", selection: $lengthUnitIndex, content: {
                                ForEach(0..<Unit.allCases.count, id:\.self){ i in
                                    Text(Unit.allCases[i].symbolName)
                                }
                            })
                        }
                        HStack{
                            TextField("Width", text: $width)
                                .keyboardType(.numberPad)
                            Picker("Unit", selection: $widthUnitIndex, content: {
                                ForEach(0..<Unit.allCases.count, id:\.self){ i in
                                    Text(Unit.allCases[i].symbolName)
                                }
                            })
                        }
                        
                    }
                    Section(header: Text("Box settings")){
                        TextField("Box size", text: $boxSize)
                    }
                }
            }
            .onChange(of: width, perform: { _ in
                recalculateWidth()
            })
            .onChange(of: length, perform: { _ in
                recalculateLength()
            })
            .onChange(of: widthUnitIndex, perform: { _ in
                recalculateWidth()
            })
            .onChange(of: lengthUnitIndex, perform: { _ in
                recalculateLength()
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Save"){
                        let tile:TileModel = .init(length: lengthUnit!, width: widthUnit!, boxSize: Int(boxSize)!)
                        model.tiles.append(tile )
                        presentation.wrappedValue.dismiss()
                        model.scrollTile = tile.id
                    }.disabled(lengthUnit == nil || widthUnit == nil || boxSize.isEmpty)
                })
            })
            .navigationTitle(Text("New Tile"))
        }
    }
    
    private func recalculateWidth(){
        withAnimation{
            error = nil
        }
        if !width.isEmpty{
            let unit = Unit.allCases[widthUnitIndex].clone(Double(width)!)
            guard unit.asFeet.value <= 3 else{
                withAnimation{
                    error = "Invalid Width"
                }
                return
            }
            withAnimation(.spring()){
                widthUnit = unit
            }
        }
    }
    
    private func recalculateLength(){
        withAnimation{
            error = nil
        }
        if !length.isEmpty{
            let unit = Unit.allCases[lengthUnitIndex].clone(Double(length)!)
            guard unit.asFeet.value <= 3 else{
                withAnimation{
                    error = "Invalid Length"
                }
                return
            }
            withAnimation(.spring()){
                lengthUnit = unit
            }
        }
    }
}

struct NewTileView_Previews: PreviewProvider {
    static var previews: some View {
        NewTileView()
    }
}
