//
//  BullsAndCowsViewController.swift
//  GuessNumberGames
//
//  Created by ycliang on 2016/8/9.
//  Copyright © 2016年 AlexLiang. All rights reserved.
//

import UIKit

class BullsAndCowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    
    var password = ""
    var passwordArray: [Int] = []
    var numOfA = 0
    var numOfB = 0
    var resultArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createPassword()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        numOfA = 0
        numOfB = 0
        
        resultArray.removeAll()
        resultTableView.reloadData()
        inputTextField.text = ""
        
        resetPassword()
        createPassword()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = resultArray[indexPath.row]
        
        return cell
    }
    
    @IBAction func confirmButtonPressed(sender: UIButton) {
        if let input = inputTextField.text {
            let inputArray: [Int] = convertStringToArray(input)
            if checkInputNumber(inputArray) == false {
                resultArray.append("Invalid Number!")
                resultTableView.reloadData()
                return
            }
            
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
            resultArray.append(("\(input) =>    \(numOfA)A\(numOfB)B"))
            resultTableView.reloadData()
        }
    }
    
    func resetPassword() {
        passwordArray.removeAll()
        password = ""
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
    
    func checkInputNumber(num: [Int]) -> Bool {
        for i in 0..<num.count {
            for j in i+1..<num.count {
                if num[i] == num[j] {
                    return false
                }
            }
        }
        
        return true
    }
}
