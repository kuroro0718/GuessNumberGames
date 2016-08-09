//
//  BullsAndCowsViewController.swift
//  GuessNumberGames
//
//  Created by ycliang on 2016/8/9.
//  Copyright © 2016年 AlexLiang. All rights reserved.
//

import UIKit

class BullsAndCowsViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    
    var password = ""
    var passwordArray: [Int] = []
    var numOfA = 0
    var numOfB = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createPassword()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmButtonPressed(sender: UIButton) {
        if let input = inputTextField.text {
            let inputArray: [Int] = convertStringToArray(input)
            numOfA = 0
            numOfB = 0
            
            for (inputIndex, inputDigit) in inputArray.enumerate() {
                for (passwordIndex, passwordDigit) in passwordArray.enumerate() {
                    if inputDigit == passwordDigit && inputIndex == passwordIndex {
                        numOfA += 1
                        break
                    } else if inputDigit == passwordDigit {                    
                        numOfB += 1
                        break
                    }
                }
            }
        }
        
        print("\(numOfA)A\(numOfB)B")
    }
    
    func createPassword() {
        while passwordArray.count < 4 {
            let num = Int(arc4random_uniform(9))
            
            if !passwordArray.contains(num) {  // Can not contain repeat number
                password += String(num)
                passwordArray.append(num)
            }
        }
        print(password)
    }
    
    func convertStringToArray(str: String) -> [Int] {
        var num = Int(str)
        var numArray: [Int] = [0, 0, 0, 0]
        var count = numArray.count - 1
        
        for _ in 0...3 {
            let n = num! % 10
            num = num! / 10
            numArray[count] = n
            count -= 1
        }
        return numArray
    }
}
