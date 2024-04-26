//
//  GameScene.swift
//  DivingGame
//
//  Created by Hans Arthur Cupiterson on 25/04/24.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var mapSize: CGSize = CGSize()
    var player = SKSpriteNode(color: SKColor.brown, size: CGSize(width: 50, height: 20))
    var cameraNode = SKCameraNode()
    let cameraZoom: CGFloat = 0.2
    var backgroundNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "MapBackground"))
        self.mapSize = backgroundNode.size
        self.size = mapSize
        
        // add camera
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
        cameraNode.xScale = cameraZoom
        cameraNode.yScale = cameraZoom
        addChild(cameraNode)
        self.camera = cameraNode
        
        let playerSize = CGSize(width: 50, height: 20)
        
        self.backgroundColor = .gray
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(backgroundNode)
        
        // disable gravity
        physicsWorld.gravity = CGVector.zero
        
        // init player
        player.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        player.physicsBody?.allowsRotation = false
        player.size = playerSize
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)
    }
    
    func movePlayer(dx: CGFloat, dy: CGFloat) {
        var movementX = dx
        if movementX < -1 {
            movementX = -0.9
        } else if movementX > 1 {
            movementX = 0.9
        }
        
        var movementY = dy
        if movementY < -1 {
            movementY = -0.9
        } else if movementY > 1 {
            movementY = 0.9
        }
        
        let movementFactor: CGFloat = 50 // adjust this factor to control the movement speed
        let movementXDistance = movementX * movementFactor // convert gyroData to movementDistance
        let movementYDistance = movementY * movementFactor * -1
        
        let newX = player.position.x + movementXDistance
        let newY = player.position.y + movementYDistance
        
        if newX + player.size.width / 2 <= frame.maxX && newX - player.size.width / 2 >= frame.minX {
            player.position.x = newX
        }
        
        if newY + player.size.height / 2 <= frame.maxY && newY - player.size.height / 2 >= frame.minY {
            player.position.y = newY
        }
        
        cameraNode.position = player.position
    }
    
//    func movePlayerUp() {
//        if(player.position.y + 20 >= frame.maxY){
//            player.position.y = frame.minY
//            return
//        }
//        
//        let moveUpAction = SKAction.moveBy(x: 0, y: 20, duration: 0.2)
//        let moveDoneAction = SKAction.run { [weak self] in
//            self?.player.position.y += 20
//        }
//        let moveGroupAction = SKAction.group([moveUpAction, moveDoneAction])
//        player.run(moveGroupAction)
//    }
//
//    func movePlayerDown() {
//        if(player.position.y - 20 <= frame.minY){
//            player.position.y = frame.maxY
//            return
//        }
//        
//        let moveDownAction = SKAction.moveBy(x: 0, y: -20, duration: 0.2)
//        let moveDoneAction = SKAction.run { [weak self] in
//            self?.player.position.y -= 20
//        }
//        let moveGroupAction = SKAction.group([moveDownAction, moveDoneAction])
//        player.run(moveGroupAction)
//    }
//    
//    func changeElevation(move: CGFloat){
//        player.position.y += move
//    }
    
//    func changeAngle(gyroData: CGFloat) {
////        let rotationFactor: CGFloat = 3 // adjust this factor to control the rotation speed
////        let rotationAngle = gyroData * rotationFactor * .pi / 180 // convert gyroData to radians
////        player.zRotation = 0 // reset the zRotation to zero
////        player.zRotation += rotationAngle // rotate the player node
//        
//        // Convert 45 degrees to radians
//        let rotationRadians = CGFloat(Double.pi / 4)
//
//        // Change the zRotation property
//        player.zRotation = rotationRadians
//    }
    
//    func changeDirection(gyroData: CGFloat) {
//        // player go to the left
//        if gyroData < 0 {
//            player.xScale = -1
//        }
//        else {
//            player.xScale = 1
//        }
//    }
    
}
