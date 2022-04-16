//
//  CalculatorView.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject var model = ViewModel()
    @State var sheet:ActiveSheet? = nil
    @State var showActionSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(model.tiles){ tile in
                        Rectangle()
                            .fill(Color.brown)
                            .frame(width: tile.width.asFeet.relativeValue, height: tile.length.asFeet.relativeValue, alignment: .center)
                            .overlay(
                                Text("\(tile.length.withSymbol) * \(tile.width.withSymbol)")
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.model.calculations.append(.init(tile: tile))
                            }
                    }
                }
            }
            
            ScrollView{
                VStack(alignment: .leading, spacing: 16){
                    ForEach(0..<model.calculations.count, id:\.self){ i in
                        CalculatorCell(calculation: $model.calculations[i])
                    }
                }
            }
            
            
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Tile master")
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text("New Calculation"), message: Text("Select the tile model to calculate"), buttons: model.tiles.map{ tile in
                    .default(Text("\(tile.length.withSymbol) * \(tile.width.withSymbol)"), action: {
                        self.model.calculations.append(.init(tile: tile))
                    })
            }.and(o: .cancel()))
        })
        .sheet(item: $sheet, content: { item in
            if item == .overlap{
                TileOverlapView()
                    .environmentObject(model)
            }
        })
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                Button(action: {
                    
                }){
                    Text("New Tile")
                }
            })
            
            ToolbarItemGroup(placement: .bottomBar, content: {
                Button(action: {
                    self.showActionSheet.toggle()
                }){
                    Text("New Calculation")
                }
                
                Button(action: {
                    self.sheet = .overlap
                }){
                    Text("Show Overlaps")
                }
            })
        })
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

struct CalculatorCell:View{
    
    @Binding var calculation:CalculationModel
    @State var length:String = ""
    @State var width:String = ""
    @State var lengthUnitIndex:Int = 0
    @State var widthUnitIndex:Int = 0
    
    var body: some View{
        VStack{
            HStack{
                TextField("Name", text: $calculation.name)
                Text("\(calculation.tile.length.withSymbol) * \(calculation.tile.width.withSymbol)")
            }
            HStack{
                Text("Length (\(calculation.length.symbol))")
                TextField("Length", text: $length)
                    .keyboardType(.numberPad)
                Picker("Unit", selection: $lengthUnitIndex, content: {
                    ForEach(0..<Unit.allCases.count, id:\.self){ i in
                        Text(Unit.allCases[i].symbolName)
                    }
                })
            }
            HStack{
                Text("Width (\(calculation.width.symbol))")
                TextField("Width", text: $width)
                    .keyboardType(.numberPad)
                Picker("Unit", selection: $widthUnitIndex, content: {
                    ForEach(0..<Unit.allCases.count, id:\.self){ i in
                        Text(Unit.allCases[i].symbolName)
                    }
                })
            }
            HStack{
                Text("Area: \(String(format: "%.1f", calculation.area))")
                Spacer()
                Text("Pieces: \(String(format: "%.1f", calculation.totalPieces))")
                Spacer()
                Text("Boxes: \(String(format: "%.1f", calculation.boxes))")
            }
        }
        .onChange(of: width, perform: { w in
            if !w.isEmpty{
                calculation.width = Unit.allCases[widthUnitIndex].clone(Double(width)!)
            }
        })
        .onChange(of: length, perform: { l in
            if !l.isEmpty{
                calculation.length = Unit.allCases[widthUnitIndex].clone(Double(length)!)
            }
        })
        .onChange(of: widthUnitIndex, perform: { i in
            calculation.width = Unit.allCases[i].clone(calculation.width.value)
        })
        .onChange(of: lengthUnitIndex, perform: { i in
            calculation.length = Unit.allCases[i].clone(calculation.length.value)
        })
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CalculatorView()
        }
    }
}
