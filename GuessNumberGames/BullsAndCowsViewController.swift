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
    
    var numOfA = 0
    var numOfB = 0
    var resultArray: [String] = []
    var passwordArray: [String] = []
    
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
        
        passwordArray.removeAll()
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
            let inputArray = input.characters.map( { String($0)} )
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
            resultArray.append(("\(input) => \(numOfA)A\(numOfB)B"))
            resultTableView.reloadData()
        }
    }
    
    func createPassword() {
        var numArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        for _ in 0...3 {
            let n = Int(arc4random_uniform(UInt32(numArray.count - 1)))
            passwordArray.append(numArray.removeAtIndex(n))
        }
        print(passwordArray)
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
    
    func checkInputNumber(num: [String]) -> Bool {
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
