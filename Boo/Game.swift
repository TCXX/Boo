//
//  Game.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class Game {
    
    var currentLevel = 0
    private var isPlaying = false
    
    
    func startGame(){
        
        //what level are we on?
        currentLevel = 1
        
        //add graphics based on level
        
        isPlaying = true
        
    }

    
    func gameStatus() {
        
    }
    
    func nextLevel() {
        
    }
    
    func gameOver() {
        //SHOW A RETRY PAGE AND CALL PLAY IF RETRY IS CALLED
        
    }
    
    
    
}
