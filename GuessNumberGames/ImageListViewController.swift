//
//  ImageListViewController.swift
//  GuessNumberGames
//
//  Created by ycliang on 2016/8/11.
//  Copyright © 2016年 AlexLiang. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {

    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchButtonPressed(sender: AnyObject) {
        if switchButton.on {
            locationImageView.clipsToBounds = true
        } else {
            locationImageView.clipsToBounds = false
        }
    }
}
