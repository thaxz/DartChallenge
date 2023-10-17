//
//  CustomARView.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import ARKit
import RealityKit
import SwiftUI
import Combine

class ARDelegate: NSObject, ARSCNViewDelegate, SCNPhysicsContactDelegate, ObservableObject {
    
    @Published var userScore: Int = 0
    private var arView: ARSCNView?
    
    var player = AVAudioPlayer()
    private var cancellables: Set<AnyCancellable> = []
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        
        arView.delegate = self
        arView.scene = SCNScene()
        arView.scene.physicsWorld.contactDelegate = self
        subscribeToActionStream()
    }
    
    func subscribeToActionStream(){
            ARManager.shared.actionsStream
                .sink { [weak self] action in
                    switch action {
                    case .placeDart(_):
                        self?.throwDart()
                    case .placeBoard:
                        print("change board position")
                    case .removeDart:
                        print("change board position")
                    case .pause:
                        self?.arView?.session.pause()
                    case .play:
                        self?.arView?.session.run(ARWorldTrackingConfiguration())
                    }
                }
                .store(in: &cancellables)
        }
    
    func throwDart(){
        let dartsNode = MyDart()
        
        let (direction, position) = self.getUserVector()
        dartsNode.position = position // SceneKit/AR coordinates are in meters
        
        let dartsDirection = direction
        dartsNode.physicsBody?.applyForce(dartsDirection, asImpulse: true)
        arView?.scene.rootNode.addChildNode(dartsNode)
    }
    
    func addNewBoard() {
        let boardNode = DartBoard()
        
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5  )
        boardNode.position = SCNVector3(posX, posY, -1) // SceneKit/AR coordinates are in meters
        arView?.scene.rootNode.addChildNode(boardNode)
    }
    
    func removeNodeWithAnimation(_ node: SCNNode, explosion: Bool) {
        
        // Play collision sound for all collisions (bullet-bullet, etc.)
        
        self.playSoundEffect(ofType: .collision)
        
        if explosion {
            
            // Play explosion sound for bullet-ship collisions
            
            self.playSoundEffect(ofType: .explosion)
            
            let particleSystem = SCNParticleSystem(named: "explosion", inDirectory: nil)
            let systemNode = SCNNode()
            systemNode.addParticleSystem(particleSystem!)
            // place explosion where node is
            systemNode.position = node.position
            arView?.scene.rootNode.addChildNode(systemNode)
        }
        
        // remove node
        node.removeFromParentNode()
    }
    
    func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        if let frame = self.arView?.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float { // random float between upper and lower bound (inclusive)
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
    // MARK: - Contact Delegate
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //print("did begin contact", contact.nodeA.physicsBody!.categoryBitMask, contact.nodeB.physicsBody!.categoryBitMask)
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.dartBoard.rawValue || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.dartBoard.rawValue { // this conditional is not required--we've used the bit masks to ensure only one type of collision takes place--will be necessary as soon as more collisions are created/enabled
            
            print("Hit ship!")
            self.removeNodeWithAnimation(contact.nodeB, explosion: false) // remove the bullet
            self.userScore += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { // remove/replace ship after half a second to visualize collision
                self.removeNodeWithAnimation(contact.nodeA, explosion: true)
                self.addNewBoard()
            })
            
        }
    }
    
    // MARK: - Sound Effects
    
    func playSoundEffect(ofType effect: SoundEffect) {
        
        // Async to avoid substantial cost to graphics processing (may result in sound effect delay however)
        DispatchQueue.main.async {
            do
            {
                if let effectURL = Bundle.main.url(forResource: effect.rawValue, withExtension: "mp3") {
                    
                    self.player = try AVAudioPlayer(contentsOf: effectURL)
                    self.player.play()
                    
                }
            }
            catch let error as NSError {
                print(error.description)
            }
        }
    }
    

}
