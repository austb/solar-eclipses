//
//  GameView.swift
//  SolarEclipses
//
//  Created by Austin Blatt on 12/4/15.
//  Copyright (c) 2015 Austin Blatt. All rights reserved.
//

import SceneKit

class GameView: SCNView, SCNSceneRendererDelegate {
    
    func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval) {
        Swift.print("updateAtTime")
    }

    func renderer(renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: NSTimeInterval) {}
    func renderer(renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: NSTimeInterval) {}
    func renderer(renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: NSTimeInterval) {}
    func renderer(renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: NSTimeInterval) {}
    
//    override func mouseDown(theEvent: NSEvent) {
//        /* Called when a mouse click occurs */
//        
//        // check what nodes are clicked
//        let p = self.convertPoint(theEvent.locationInWindow, fromView: nil)
//        let hitResults = self.hitTest(p, options: nil)
//        // check that we clicked on at least one object
//        if hitResults.count > 0 {
//            // retrieved the first clicked object
//            let result: AnyObject = hitResults[0]
//            
//            // get its material
//            let material = result.node!.geometry!.firstMaterial!
//            
//            // highlight it
//            SCNTransaction.begin()
//            SCNTransaction.setAnimationDuration(0.5)
//            
//            // on completion - unhighlight
//            SCNTransaction.setCompletionBlock() {
//                SCNTransaction.begin()
//                SCNTransaction.setAnimationDuration(0.5)
//                
//                material.emission.contents = NSColor.blackColor()
//                
//                SCNTransaction.commit()
//            }
//            
//            material.emission.contents = NSColor.redColor()
//            
//            SCNTransaction.commit()
//        }
//        
//        super.mouseDown(theEvent)
//    }

}
