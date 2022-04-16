//
//  Unit.swift
//  Tiles
//
//  Created by Bidan on 16/04/2022.
//

import Foundation

enum Unit: Codable, Identifiable, CaseIterable, Hashable{
    static var allCases: [Unit] = [.feet(.nan), .inches(.nan), .metres(.nan)]
    
    case inches(Double)
    case feet(Double)
    case metres(Double);
    
    var clone:(Double)->Unit{
        switch self{
        case .metres:
            return Unit.metres
        case .inches:
            return Unit.inches
        case .feet:
            return Unit.feet
        }
    }
    
    var id:String{
        return UUID().uuidString
    }
    
    var withSymbol:String{
        switch self{
        case .feet(let v):
            return String(format: "%.0fft", v)
        case .inches(let v):
            return String(format: "%.0fin", v)
        case .metres(let v):
            return String(format: "%.0fm", v)
        }
    }
    
    var symbol:String{
        switch self{
        case .feet:
            return "ft"
        case .inches:
            return "in"
        case .metres:
            return "m"
        }
    }
    
    var symbolName:String{
        switch self{
        case .feet:
            return "Feet"
        case .inches:
            return "Inches"
        case .metres:
            return "Metres"
        }
    }
    
    var value:Double{
        switch self{
        case .feet(let v):
            return v
        case .inches(let v):
            return v
        case .metres(let v):
            return v
        }
    }
    
    /*
     Converts the measurements to view dimensions coz some measurements are 1 which can't be seen on the view
     */
    var relativeValue:Double{
        return value * 100
    }
    
    var asFeet:Unit{
        switch self{
        case .metres(let value):
            return .feet(value * 3.28084)
        case .inches(let value):
            return .feet(value/12)
        default:
            return self
        }
    }
    
    
    var asInches:Unit{
        switch self{
        case .metres(let value):
            return .feet(value * 39.3701)
        case .feet(let value):
            return .inches(value * 12)
        default:
            return self
        }
    }
    
}
