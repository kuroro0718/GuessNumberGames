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
    var password: Int?
    var remainedNumbers: Int?
    
    init(rangeStart: Int, rangeEnd: Int) {
        self.rangeStart = rangeStart
        self.rangeEnd = rangeEnd
        self.createFinalCode(rangeStart, rangeEnd: rangeEnd)
    }
    
    func createFinalCode(rangeStart: Int, rangeEnd: Int) {
        password = Int(arc4random_uniform(UInt32(rangeStart)) + UInt32(rangeEnd))
    }
    
    func isInputNumberValid(inputNumber: Int) -> Bool {
        if inputNumber < rangeStart || inputNumber > rangeEnd {
            return false
        }
        
        return true
    }
    
    func isEqualToFinalCode(inputNumber: Int) -> Bool {
        var isEqualToFinalCode = false
        
        if inputNumber < password {
            rangeStart = inputNumber + 1
        } else if inputNumber > password {
            rangeEnd = inputNumber
        } else {
            isEqualToFinalCode = true
        }
        
        return isEqualToFinalCode
    }
    
    func calculateRemainedNumbers() -> Int {
        return rangeEnd - rangeStart + 1
    }
}