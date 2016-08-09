//
//  FinalCodeViewController.swift
//  GuessNumberGames
//
//  Created by ycliang on 2016/8/9.
//  Copyright © 2016年 AlexLiang. All rights reserved.
//

import UIKit

class FinalCodeViewController: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    var password: Int?
    var rangeStart: Int = 0
    var rangeEnd: Int = 99
    var playerIndex = 0
    var playerList = ["Alex", "Jeff", "John", "Peter"]
    
    
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
        if let inputNumber = Int(inputTextField.text!) {
            if inputNumber < rangeStart || inputNumber > rangeEnd {
                return
            }
            
            if inputNumber < password! {
                rangeStart = inputNumber + 1
                updateResultLable()
            } else if inputNumber > password! {
                rangeEnd = inputNumber
                updateResultLable()
            } else {
                resultLabel.text? = "\(playerList[playerIndex]) 你輸了！"
            }
            
            inputTextField.text = ""
            updatePlayerName()
        }
    }
    
    func createPassword() {
        rangeStart = 1
        rangeEnd = 100
        resultLabel.text = "0 ~ 100"
        password = Int(arc4random_uniform(99) + 1)
        print(password)
    }
    
    func updateResultLable() {
        resultLabel.text? = "\(rangeStart) ~ \(rangeEnd)"
    }
    
    func updatePlayerName() {
        playerNameLabel.text = playerList[playerIndex]
        
        if playerIndex == playerList.count-1 {
            playerIndex = 0
        } else {
            playerIndex += 1
        }
    }
}
