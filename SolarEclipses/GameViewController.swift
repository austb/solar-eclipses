//
//  GameViewController.swift
//  SolarEclipses
//
//  Created by Austin Blatt on 12/4/15.
//  Copyright (c) 2015 Austin Blatt. All rights reserved.
//

import SceneKit
import QuartzCore

let gravityCategory     =  0x1 << 0;
let shieldCategory      =  0x1 << 1;
let lightShadowCategory =  0x1 << 2;

class GameViewController: NSViewController {
    
    @IBOutlet weak var gameView: GameView!
    
    override func awakeFromNib(){
        // create a new scene
        let scene = SCNScene();
        
        // Set up the PhysicsWorld
        scene.physicsWorld.gravity = SCNVector3(0,0,0);
        
        scene.physicsWorld.speed = 1.0
        
        // Create a sphere to represent the Earth
        let earth = SCNSphere(radius: 6.371)
        
        earth.firstMaterial = SCNMaterial()
        earth.firstMaterial?.diffuse.contents = NSImage(named: "Diffuse.png")
        earth.firstMaterial?.specular.contents = NSImage(named: "Specular.png")
        earth.firstMaterial?.emission.contents = NSImage(named: "Emission.png")
        earth.firstMaterial?.normal.contents = NSImage(named: "Normal.png")
        if earth.firstMaterial?.diffuse.contents == nil {
            return
        }
//        earth.firstMaterial?.specular.contents = NSImage(named: "Specular.png")
        
        let earthNode = SCNNode(geometry: earth)
        earthNode.name = "earth"
        
        // Create a PhysicsBody for the Earth
        earthNode.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Static, shape: SCNPhysicsShape(geometry: earth, options: [String: AnyObject]()))
        earthNode.physicsBody?.mass = 358.262// 5.972e24
        
        let gravity = SCNPhysicsField.radialGravityField();
        gravity.categoryBitMask = gravityCategory;
        gravity.active = true
        gravity.strength = 100 //273.7
        earthNode.physicsField = gravity
        
        // Add rotation
//        let earthRotation = SCNAction.rotateByAngle(360 * CGFloat(M_PI/180.0), aroundAxis: SCNVector3(0,1,0), duration: 1.28)
        let earthRotation = SCNAction.rotateByAngle(360 * CGFloat(M_PI/180.0), aroundAxis: SCNVector3(0,1,0), duration: 24)
        
        // Tilt rotation SCNVector3(0,0.9171,-0.39875)
        
        let continuousEarthRotation = SCNAction.repeatActionForever(earthRotation)
        earthNode.runAction(continuousEarthRotation)
        
        // Add tilt
//        earthNode.rotation = SCNVector4(0, 0, 1, (M_PI*0.13))

        // Add the Earth to the scene
        scene.rootNode.addChildNode(earthNode)
        
        // Create a sphere to represent the Moon
        let moon = SCNSphere(radius: 1.737) // 1.737
        let moonNode = SCNNode(geometry: moon)
        moonNode.name = "moon"
        
        // Create a PhysicsBody for the Moon
        moonNode.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Dynamic, shape: SCNPhysicsShape(geometry: moon, options: [String: AnyObject]()))

        moonNode.physicsBody?.damping = 0.0
        moonNode.physicsBody?.angularDamping = 0.0

        moonNode.physicsBody?.mass = 4.408 // 7.347e22
        moonNode.physicsBody?.velocity = SCNVector3(0, -1.09, -2.0)
        
        moonNode.categoryBitMask = gravityCategory
        
        moonNode.position = SCNVector3Make(15, 0, 0)
//        moonNode.position = SCNVector3Make(384, 0, 0)
        
        // Add the Moon to the scene
        scene.rootNode.addChildNode(moonNode)
        
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 40)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeSpot
        lightNode.light?.castsShadow = true
        lightNode.light?.shadowMode = SCNShadowMode.Forward
        lightNode.light?.spotInnerAngle = 70.0
        lightNode.light?.spotOuterAngle = 90.0
        lightNode.light?.zNear = 1.0
        lightNode.light?.zFar = 10000.0
        
        lightNode.orientation = SCNQuaternion(0, 1, 0, M_PI/2);
        lightNode.position = SCNVector3(x: 40, y: 0, z: 0)
//        lightNode.position = SCNVector3(x: 755, y: 0, z: 0)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = SCNLightTypeAmbient
//        ambientLightNode.light!.color = NSColor(white: 0.2, alpha: 1.0)
//        scene.rootNode.addChildNode(ambientLightNode)

        
        // set the scene to the view
        self.gameView!.scene = scene
//        self.gameView!.autoenablesDefaultLighting = true
        
        // allows the user to manipulate the camera
        self.gameView!.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // configure the view
        self.gameView!.backgroundColor = NSColor.blackColor()
    }

}
