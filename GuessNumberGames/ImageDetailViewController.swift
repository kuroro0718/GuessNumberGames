//
//  ImageDetailViewController.swift
//  GuessNumberGames
//
//  Created by ycliang on 2016/8/11.
//  Copyright © 2016年 AlexLiang. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailImageView.image = UIImage(named: imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
