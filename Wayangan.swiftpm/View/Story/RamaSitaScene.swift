//
//  File.swift
//  
//
//  Created by Ahmad Fariz on 18/04/23.
//

import SpriteKit
import Combine

class RamaSitaScene: SKScene {
    
    let dataDialogueAndClue : PassGameDialogueAndClueData
    
    init(dataDialogueAndClue : PassGameDialogueAndClueData) {
            self.dataDialogueAndClue = dataDialogueAndClue
            super.init(size: .zero)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    var gridRows = 3
    var gridColumns = 8
    var cellSize: CGSize {return CGSize(width: size.width / CGFloat(gridColumns), height: size.height / CGFloat(gridRows))}
    var gridCenterPoints = [String: CGPoint]()
    
    var selectedNode: SKNode?
    
    var wayangs = [Wayang]()
    var triggers = [Trigger]()
    
    var dialogueCount: Int = 0
    var clueCount: Int = 0
    
    override func didMove(to view: SKView) {
        drawGrid()
        addLabelsToGrid()
        let wayangTypes: [WayangName] = [.rama,.hanuman,.sita,.rahwana]
        let startColumn = (Int(size.width / cellSize.width) - wayangTypes.count-1) / 2
        for (index, type) in wayangTypes.enumerated() {
            let wayang = WayangFactory.createWayang(type: type)
            wayangs.append(wayang)
            if let sprite = wayang.currentPose{
                if let centerPoint = gridCenterPoints["0,\(startColumn + index + 1)"] {
                    sprite.position = centerPoint
                    addChild(sprite)
                }
            }
        }
        
        let trigger1 = spawnTrigger(wayangType: .rama, pose: .stand, position: gridCenterPoints["1,2"]!)
        triggers.append(trigger1)
        let trigger2 = spawnTrigger(wayangType: .sita, pose: .stand, position: gridCenterPoints["1,5"]!)
        triggers.append(trigger2)
        let trigger3 = spawnTrigger(wayangType: .rahwana, pose: .stand, position: gridCenterPoints["1,4"]!)
        triggers.append(trigger3)
        let trigger4 = spawnTrigger(wayangType: .hanuman, pose: .stand, position: gridCenterPoints["1,4"]!)
        triggers.append(trigger4)
        let trigger5 = spawnTrigger(wayangType: .rahwana, pose: .fight, position: gridCenterPoints["2,4"]!)
        triggers.append(trigger5)
        let trigger6 = spawnTrigger(wayangType: .hanuman, pose: .fight, position: gridCenterPoints["2,3"]!)
        triggers.append(trigger6)
        let trigger7 = spawnTrigger(wayangType: .rama, pose: .fight, position: gridCenterPoints["1,1"]!)
        triggers.append(trigger7)
        let trigger8 = spawnTrigger(wayangType: .sita, pose: .sit, position: gridCenterPoints["1,4"]!)
        triggers.append(trigger8)
        let trigger9 = spawnTrigger(wayangType: .rama, pose: .sit, position: gridCenterPoints["1,3"]!)
        triggers.append(trigger9)
        
        resetPosition(wayangs: wayangs, clue: dataDialogueAndClue.dialogueKey)
        print(dataDialogueAndClue.dialogueKey)
    }
    func drawGrid() {
        let rows = Int(size.height / cellSize.height)
        let columns = Int(size.width / cellSize.width)
        
        for i in 0..<rows {
            for j in 0..<columns {
                let centerPoint = CGPoint(x: (CGFloat(j) + 0.5) * cellSize.width,
                                          y: (CGFloat(i) + 0.5) * cellSize.height)
                gridCenterPoints["\(i),\(j)"] = centerPoint
            }
        }
    }
    func addLabelsToGrid() {
        for (index, centerPoint) in gridCenterPoints {
            let label = SKLabelNode(text: index)
            label.position = centerPoint
            addChild(label)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        if let touchedNode = touchedNodes.first {
            selectedNode = touchedNode
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        selectedNode?.position = location
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?) {
        if let selectedNode=selectedNode as?SKSpriteNode,
           let wayang=wayangs.first(where:{ $0.currentPose == selectedNode}) {
            wayang.changePose()
        }
        if let selectedNodePosition=selectedNode?.position{
            var closestDistance=CGFloat.greatestFiniteMagnitude
            var closestPointKey=""
            for(key,point)in gridCenterPoints{
                let distance=hypot(selectedNodePosition.x-point.x,
                                   selectedNodePosition.y-point.y)
                if distance<closestDistance{
                    closestDistance=distance
                    closestPointKey=key
                }
            }
            
            if !closestPointKey.isEmpty,
               let closestPointValue=gridCenterPoints[closestPointKey]{
                selectedNode?.position=closestPointValue
                
                print(checkForTrigger(wayang: wayangs.first(where: { $0.currentPose == selectedNode }), gridPoint: closestPointValue, triggers: triggers))
                dataDialogueAndClue.dialogueKey = dialogueController(casewayang: checkForTrigger(wayang: wayangs.first(where: { $0.currentPose == selectedNode }), gridPoint: closestPointValue, triggers: triggers), dialogueCount: dialogueCount)
                dialogueCount = dataDialogueAndClue.dialogueKey
                dataDialogueAndClue.clueKey = clueController(dialogueCount: dataDialogueAndClue.dialogueKey, clueCount : clueCount)
                resetPosition(wayangs: wayangs, clue: dialogueCount)
                
            }
            
            selectedNode?.zPosition+=1
        }
        selectedNode=nil
    }
    func checkForTrigger(wayang: Wayang?, gridPoint: CGPoint, triggers: [Trigger]) -> String {
        guard let wayang = wayang else { return ""}
        var valid:String = ""
        for trigger in triggers {
            if trigger.isTriggered(by: wayang) && trigger.position == gridPoint {
                wayang.shake()
                valid = "triggered by \(wayang.type) in \(String(describing: wayang.poseType)) position"
                break
            }
            else{
                valid = ""
                
            }
        }
        return valid
    }
    
    func spawnTrigger(wayangType: WayangName, pose: WayangPose, position: CGPoint) -> Trigger {
        let wayang = WayangFactory.createWayang(type: wayangType)
        let trigger = Trigger(wayang: wayang, wayangType: wayangType, pose: pose, position: position)
        return trigger
    }
    func dialogueController(casewayang : String, dialogueCount: Int)-> Int{
        switch (casewayang, dialogueCount) {
        case ("triggered by rama in Optional(Wayangan.WayangPose.stand) position", 0):
            return 1
        case ("triggered by sita in Optional(Wayangan.WayangPose.stand) position", 1):
            return 2
        case ("triggered by rahwana in Optional(Wayangan.WayangPose.stand) position", 2):
            return 3
        case ("triggered by hanuman in Optional(Wayangan.WayangPose.stand) position", 3):
            return 4
        case ("triggered by rahwana in Optional(Wayangan.WayangPose.fight) position", 4):
            return 5
        case ("triggered by hanuman in Optional(Wayangan.WayangPose.fight) position", 5):
            return 6
        case ("triggered by rama in Optional(Wayangan.WayangPose.fight) position", 6):
            return 7
        case ("triggered by sita in Optional(Wayangan.WayangPose.sit) position", 7):
            return 8
        case ("triggered by rama in Optional(Wayangan.WayangPose.sit) position", 8):
            return 9
        default:
            return dialogueCount
        }
    }
    func clueController(dialogueCount : Int,clueCount: Int)-> Int{
        switch dialogueCount{
        case 3: return 1
        case 4: return 2
        case 7: return 3
        case 9: return 4
        default:
            return clueCount
        }
    }
    func resetPosition(wayangs : [Wayang],clue : Int){
        var count: Int = 0
        switch clue{
        case 3,4,7,9 :
                for wayang in wayangs {
                    let wait = SKAction.wait(forDuration: 2.0)
                    let moveAction = SKAction.move(to: gridCenterPoints["0,\(2 + count )"]!, duration: 1.0)
                    let sequence = SKAction.sequence([wait, moveAction])
                    wayang.currentPose?.run(sequence)
                    count+=1
                }
                break
        default : return
        }
    }
}

struct Trigger {
    let wayang : Wayang
    let wayangType: WayangName
    let pose: WayangPose?
    let position : CGPoint
    
    func isTriggered(by wayang: Wayang) -> Bool {
        return wayang.type == wayangType && wayang.poseType == pose
    }
}
