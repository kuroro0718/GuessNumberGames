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
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var passButton: UIButton!

    var playerIndex = 0
    var listIncrement = 1
    var currentPlayer = ""
    
    var finalCode = FinalCode(rangeStart: 0, rangeEnd: 100)
    var playerList = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPlayerImageView.layer.cornerRadius = currentPlayerImageView.frame.size.width / 2
        nextPlayerImageView.layer.cornerRadius = nextPlayerImageView.frame.size.width / 2
        
        // Do any additional setup after loading the view.        
        createPlayerList()
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
                resultLabel.text? = "\(currentPlayer) 你輸了！"
                return
            }
            
            inputTextField.text = ""
            updateResultLabel()
            updatePlayerName()
            updateRemainedNumberLabel()
        }
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        inputTextField.text = ""
        finalCode.rangeStart = 0
        finalCode.rangeEnd = 100
        finalCode.createFinalCode(finalCode.rangeStart, rangeEnd: finalCode.rangeEnd)
        
        updateResultLabel()
        createPlayerList()
        updatePlayerName()
        updateRemainedNumberLabel()
    }
    
    @IBAction func returnButtonPressed(sender: AnyObject) {
        playerList[playerIndex].hasReturned = true
        playerIndex -= 1
        listIncrement = -1
        
        updatePlayerName()
    }
    
    @IBAction func passButtonPressed(sender: AnyObject) {
        playerList[playerIndex - 1].hasPassed = true
        listIncrement = 1
        
        updatePlayerName()
    }
    
    func updateResultLabel() {
        resultLabel.text? = "\(finalCode.rangeStart) ~ \(finalCode.rangeEnd)"
    }
    
    func updatePlayerName() {
        var player = playerList[playerIndex]
        
        currentPlayer = player.name
        playerNameLabel.text = "目前玩家： \(currentPlayer)"
        currentPlayerImageView.image = UIImage(named: player.imageName)
        
        updateSkipButtons(player)
        updatePlayerIndex()
        
        player = playerList[playerIndex]
        nextPlayerLabel.text = "下一位玩家： \(player.name)"
        nextPlayerImageView.image = UIImage(named: player.imageName)
    }
    
    func updateRemainedNumberLabel() {
        let remainedNumber = finalCode.calculateRemainedNumbers()
        remainedNumberLabel.text = "Remain: \(remainedNumber) numbers"
    }
    
    func updatePlayerIndex() {
        var wasNegative = false
        
        playerIndex += listIncrement
        if playerIndex < 0 {
            wasNegative = true
            playerIndex = -playerIndex
        } else if playerIndex > playerList.count - 1 {
            playerIndex = 0
        }
        
        playerIndex %= playerList.count
        if wasNegative {
            playerIndex = playerList.count - playerIndex
        }
    }
    
    func updateSkipButtons(player: Player) {
        
        if player.hasReturned {
            returnButton.enabled = false
        } else {
            returnButton.enabled = true
        }
        
        if player.hasPassed {
            passButton.enabled = false
        } else {
            passButton.enabled = true
        }
    }
    
    func createPlayerList() {
        
        playerIndex = 0
        
        playerList.append(Player(name: "Alex", imageName: "alex", hasReturned: false, hasPassed: false))
        playerList.append(Player(name: "Jeff", imageName: "jeff", hasReturned: false, hasPassed: false))
        playerList.append(Player(name: "John", imageName: "john", hasReturned: false, hasPassed: false))
        playerList.append(Player(name: "Peter", imageName: "peter", hasReturned: false, hasPassed: false))
        
//        let count = playerList.count
//        for i in 0..<count - 1 {
//            let j = Int(arc4random_uniform(UInt32(count - i))) + i
//            guard i != j else { continue }
//            swap(&playerList[i], &playerList[j])
//        }
    }
}
