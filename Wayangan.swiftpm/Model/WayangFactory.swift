//
//  File.swift
//  
//
//  Created by Ahmad Fariz on 16/04/23.
//

import Foundation
import SpriteKit

class WayangFactory {
    static func createWayang(type: WayangName) -> Wayang {
        switch type {
        case .bird:
            return BirdWayang()
        case .fish:
            return FishWayang()
        case .lizard:
            return LizardWayang()
        case .hare:
            return HareWayang()
        case .rama:
            return Rama()
        case .rahwana:
            return Rahwana()
        case .sita:
            return Sita()
        case .hanuman:
            return Hanuman()
        default:
            fatalError("Unknown type")
        }
    }
}

enum WayangName : String, CaseIterable {
    case rama
    case sita
    case hanuman
    case rahwana
    case bird
    case fish
    case lizard
    case hare
}
