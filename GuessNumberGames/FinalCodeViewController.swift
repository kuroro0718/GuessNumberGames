//
//  FinalCodeViewController.swift
//  GuessNumberGames
//
//  Created by ycliang on 2016/8/9.
//  Copyright © 2016年 AlexLiang. All rights reserved.
//

import UIKit

class FinalCodeViewController: UIViewController {

    @IBOutlet weak var nextPlayerImageView: UIImageView!
    @IBOutlet weak var currentPlayerImageView: UIImageView!
    @IBOutlet weak var nextPlayerLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var remainedNumberLabel: UILabel!

    var previousPlayerIndex = 0 // For skip guessing
    var currentPlayerIndex = 1
    var playerIndex = 0
    var playerList = ["Alex", "Jeff", "John", "Peter"]
    var playerSkipDict = [String : Int]()

    var finalCode = FinalCode(rangeStart: 0, rangeEnd: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPlayerImageView.layer.cornerRadius = currentPlayerImageView.frame.size.width / 2
        nextPlayerImageView.layer.cornerRadius = nextPlayerImageView.frame.size.width / 2
        
        // Do any additional setup after loading the view.        
        //shufflePlayerList()
        updatePlayerName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmButtonPressed(sender: UIButton) {
        if let inputNumber = Int(inputTextField.text!) {
            if finalCode.isInputNumberValid(inputNumber) == false {
                return
            }
            
            if finalCode.isEqualToFinalCode(inputNumber) == true {
                resultLabel.text? = "\(playerList[playerIndex - 1]) 你輸了！"
                return
            }
            
            inputTextField.text = ""
            updateResultLabel()
            updatePlayerName()
            updateRemainedNumberLabel()
        }
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        //shufflePlayerList()
        
        playerIndex = 0
        updatePlayerName()
    }
    
    @IBAction func returnButtonPressed(sender: AnyObject) {
        previousPlayerIndex -= 1
        if previousPlayerIndex < 0 {
            previousPlayerIndex += 4
        }
        
        var playerName = playerList[previousPlayerIndex]
        
        playerNameLabel.text = "目前玩家： \(playerName)"
        currentPlayerImageView.image = UIImage(named: playerName.lowercaseString)
        
        currentPlayerIndex -= 1
        if currentPlayerIndex < 0 {
            currentPlayerIndex += 4
        }
        playerName = playerList[currentPlayerIndex]
        nextPlayerLabel.text = "下一位玩家： \(playerName)"
        nextPlayerImageView.image = UIImage(named: playerName.lowercaseString)
    }
    
    @IBAction func passButtonPressed(sender: AnyObject) {
        previousPlayerIndex += 1
        if previousPlayerIndex >= playerList.count  {
            previousPlayerIndex = 0
        }
        
        var playerName = playerList[previousPlayerIndex]
        
        playerNameLabel.text = "目前玩家： \(playerName)"
        currentPlayerImageView.image = UIImage(named: playerName.lowercaseString)
        
        currentPlayerIndex += 1
        if currentPlayerIndex >= playerList.count {
            currentPlayerIndex = 0
        }
        playerName = playerList[currentPlayerIndex]
        nextPlayerLabel.text = "下一位玩家： \(playerName)"
        nextPlayerImageView.image = UIImage(named: playerName.lowercaseString)
    }
    
    func updateResultLabel() {
        resultLabel.text? = "\(finalCode.rangeStart) ~ \(finalCode.rangeEnd)"
    }
    
    func updatePlayerName() {
        var playerName = playerList[playerIndex]
        
        playerNameLabel.text = "目前玩家： \(playerName)"
        currentPlayerImageView.image = UIImage(named: playerName.lowercaseString)
        
        if playerIndex == playerList.count-1 {
            playerIndex = 0
        } else {
            playerIndex += 1
        }
        playerName = playerList[playerIndex]
        nextPlayerLabel.text = "下一位玩家： \(playerName)"
        nextPlayerImageView.image = UIImage(named: playerName.lowercaseString)
    }
    
    func updateRemainedNumberLabel() {
        let remainedNumber = finalCode.calculateRemainedNumbers()
        remainedNumberLabel.text = "Remain: \(remainedNumber) numbers"
    }
    
    func shufflePlayerList() {
        let count = playerList.count
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&playerList[i], &playerList[j])
        }
        
        print(playerList)
    }
}
