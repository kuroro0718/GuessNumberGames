//
//  FinalCode.swift
//  GuessNumberGames
//
//  Created by ycliang on 2016/8/15.
//  Copyright © 2016年 AlexLiang. All rights reserved.
//

import Foundation

class FinalCode {
    var rangeStart: Int
    var rangeEnd: Int
    var password: Int
    
    init(password: Int, rangeStart: Int, rangeEnd: Int) {
        self.password = password
        self.rangeStart = rangeStart
        self.rangeEnd = rangeEnd
    }
    
    convenience init(rangeStart: Int, rangeEnd: Int) {
        let password = Int(arc4random_uniform(99) + 1)
        self.init(password: password, rangeStart: rangeStart, rangeEnd: rangeEnd)
    }
    
    func createFinalCode() {
        password = Int(arc4random_uniform(99) + 1)
        rangeStart = 1
        rangeEnd = 100
    }
    
    func isInputNumberValid(inputNumber: Int) -> Bool {
        if inputNumber < rangeStart || inputNumber > rangeEnd {
            return false
        }
        
        return true
    }
    
    func compareFinalCode(inputNumber: Int) -> (result: Bool, rangeStart: Int, rangeEnd: Int) {
        var isEqualToFinalCode = false
        
        if inputNumber < password {
            rangeStart = inputNumber + 1
        } else if inputNumber > password {
            rangeEnd = inputNumber
        } else {
            isEqualToFinalCode = true
        }
        
        return (isEqualToFinalCode, rangeStart, rangeEnd)
    }
    
}