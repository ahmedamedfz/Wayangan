//
//  GameScene.swift
//  
//
//  Created by Ahmad Fariz on 17/04/23.
//

import SpriteKit

class GameScene: SKScene {
    let cellSize = CGSize(width: 108, height: 108)
    var gridCenterPoints = [String: CGPoint]()
    var selectedNode: SKNode?
    var wayangs = [Wayang]()
    
    override func didMove(to view: SKView) {
        drawGrid()
        addLabelsToGrid()
        let wayangTypes: [WayangName] = [.bird, .fish, .lizard, .hare]
        let startColumn = (Int(size.width / cellSize.width) - wayangTypes.count) / 2
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
    }
    
    func drawGrid() {
        let rows = Int(size.height / cellSize.height)
        let columns = Int(size.width / cellSize.width)
        
        for i in 0...rows {
            let startPoint = CGPoint(x: 0, y: CGFloat(i) * cellSize.height)
            let endPoint = CGPoint(x: size.width, y: startPoint.y)
            drawLine(from: startPoint, to: endPoint)
        }

        for i in 0...columns {
            let startPoint = CGPoint(x: CGFloat(i) * cellSize.width, y: 0)
            let endPoint = CGPoint(x: startPoint.x, y: size.height)
            drawLine(from: startPoint, to: endPoint)
        }
        
        for i in 0..<rows {
            for j in 0..<columns {
                let centerPoint = CGPoint(x: (CGFloat(j) + 0.5) * cellSize.width,
                                          y: (CGFloat(i) + 0.5) * cellSize.height)
                gridCenterPoints["\(i),\(j)"] = centerPoint
            }
        }
    }
//    func checkForTrigger(wayang: Wayang, gridCenterPoint: CGPoint) {
//        if let wayang = Wayang,
//            Wayang.currentPose?.texture == fishWayang.fight,
//            Wayang.currentPose?.position == gridCenterPoints["3,4"] {
//            print("Kembung")
//        }
//    }
//
    func drawLine(from startPoint: CGPoint, to endPoint: CGPoint) {
        let line = SKShapeNode()
        let path = CGMutablePath()
        path.addLines(between: [startPoint, endPoint])
        line.path = path
        line.strokeColor = .darkGray
        addChild(line)
    }
    
    func addLabelsToGrid() {
            for (index, centerPoint) in gridCenterPoints {
                let label = SKLabelNode(text: index)
                label.position = centerPoint
                addChild(label)
            }
        }
    
    func addLabelToSpecificCell(column: Int, row: Int, text: String) {
            if let centerPoint = gridCenterPoints["\(column),\(row)"] {
                let label = SKLabelNode(text: text)
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
        if let selectedNode = selectedNode as?SKSpriteNode,
           let wayang = wayangs.first(where:{ $0.currentPose == selectedNode}) {
                    wayang.changePose()
            print(wayang.currentPose?.texture! as Any)
//           
            print(wayang.currentPose?.position as Any)
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
                  }

                  selectedNode?.zPosition+=1
              }
              selectedNode=nil
          }
}
