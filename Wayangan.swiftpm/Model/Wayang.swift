//
//  File.swift
//  
//
//  Created by Ahmad Fariz on 15/04/23.
//

import Foundation
import SpriteKit

protocol Wayang : AnyObject {
    var id: UUID { get }
    var stand: SKTexture? { get }
    var fight: SKTexture? { get }
    var sit: SKTexture? { get }
    var currentPose: SKSpriteNode? {get set}
    var type: WayangName { get }
    var poseType: WayangPose? { get set}
}

enum WayangPose {
    case stand, fight, sit
}

extension Wayang {
 
    func changePose() {
        let poses = [stand, fight, sit]
        
        if let currentTexture = currentPose?.texture,
            let currentIndex = poses.firstIndex(where: { $0 == currentTexture }) {
            var nextIndex = (currentIndex + 1) % poses.count
            while poses[nextIndex] == nil && nextIndex != currentIndex {
                nextIndex = (nextIndex + 1) % poses.count
            }
            if let nextPose = poses[nextIndex] {
                currentPose?.texture = nextPose
                if nextPose == stand {
                    poseType = .stand
                } else if nextPose == fight {
                    poseType = .fight
                } else if nextPose == sit {
                    poseType = .sit
                }
            }
        } else {
            if let firstPose = poses.first(where: { $0 != nil }) {
                currentPose?.texture = firstPose
            }
        }
    }
    func shake() {
        let shakeAnimation = SKAction.sequence([
            SKAction.moveBy(x: 0, y: 30, duration: 0.05),
            SKAction.moveBy(x: 0, y: -10, duration: 0.1),
            SKAction.moveBy(x: 0, y: 40, duration: 0.1),
            SKAction.moveBy(x: 0, y: -30, duration: 0.1),
            SKAction.moveBy(x: 0, y: -30, duration: 0.05)
        ])
        currentPose?.run(shakeAnimation)
    }
}

class FishWayang : Wayang{
    var poseType: WayangPose?
    
    var type: WayangName = .fish
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
 
 init() {
        stand = SKTexture.init(image: UIImage.init(systemName: "fish")!)
        fight = SKTexture.init(image: UIImage.init(systemName: "fish.circle")!)
        sit = SKTexture.init(image: UIImage.init(systemName: "fish.fill")!)
        currentPose = SKSpriteNode(texture: stand, color: .white, size: CGSize(width: 64, height: 64))
        }
    
}
class BirdWayang : Wayang{
    
    var poseType: WayangPose?
    
    var type: WayangName = .bird
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
    init() {
        stand = SKTexture.init(image: UIImage.init(systemName: "bird")!)
        fight = nil
        sit = SKTexture.init(image: UIImage.init(systemName: "bird.fill")!)
        currentPose = SKSpriteNode(texture: stand, color: .white, size: CGSize(width: 64, height: 64))
        }
}
class LizardWayang : Wayang{
    
    var poseType: WayangPose?
    
    var type: WayangName = .lizard
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
    init() {
        stand = SKTexture.init(image: UIImage.init(systemName: "lizard")!)
        fight = nil
        sit = SKTexture.init(image: UIImage.init(systemName: "lizard.fill")!)
        currentPose = SKSpriteNode(texture: stand, color: .white, size: CGSize(width: 64, height: 64))
        }
    
}
class HareWayang : Wayang{
    
    var poseType: WayangPose?
    
    var type: WayangName = .hare
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
    init() {
        stand = SKTexture.init(image: UIImage.init(systemName: "hare")!)
        fight = nil
        sit = nil
        currentPose = SKSpriteNode(texture: stand, color: .white, size: CGSize(width: 64, height: 64))
        }
}


class Rama : Wayang {
    
    var poseType: WayangPose?
    
    var type: WayangName = .rama
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
    init() {
           stand = SKTexture(imageNamed: "RamaStand")
           fight = SKTexture(imageNamed: "RamaFight")
           sit = SKTexture(imageNamed: "RamaSit")
           currentPose = SKSpriteNode(texture: stand,size: CGSize(width: 128, height: 128))
           }
    
}

class Sita : Wayang {
    
    var poseType: WayangPose?
    
    var type: WayangName = .sita
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
    init() {
           stand = SKTexture(imageNamed: "SitaStand")
           fight = nil
           sit = SKTexture(imageNamed: "SitaSit")
           currentPose = SKSpriteNode(texture: stand,size: CGSize(width: 128, height: 128))
           }
}

class Hanuman : Wayang{
    
    var poseType: WayangPose?
    
    var type: WayangName = .hanuman
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
    init() {
           stand = SKTexture(imageNamed: "HanomanStand")
           fight = SKTexture(imageNamed: "HanomanFight")
           sit = nil
           currentPose = SKSpriteNode(texture: stand,size: CGSize(width: 128, height: 128))
           }
}

class Rahwana : Wayang{
    
    var poseType: WayangPose?
    
    var type: WayangName = .rahwana
    
    var stand: SKTexture?
    
    var fight: SKTexture?
    
    var sit: SKTexture?
    
    var id = UUID()
    
    var currentPose: SKSpriteNode?
    
    init() {
           stand = SKTexture(imageNamed: "RahwanaStand")
           fight = SKTexture(imageNamed: "RahwanaFight")
           sit = nil
           currentPose = SKSpriteNode(texture: stand,size: CGSize(width: 128, height: 128))
           }

}

