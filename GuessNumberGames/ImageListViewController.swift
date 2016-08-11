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
    @IBOutlet weak var citySegmentedControl: UISegmentedControl!
    
    var imageName = "tokyo"
    
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
    
    @IBAction func citySegmentedControlChanged(sender: AnyObject) {
        switch citySegmentedControl.selectedSegmentIndex {
        case 0: imageName = "tokyo"
        case 1: imageName = "kyoto"
        case 2: imageName = "yokohama"
        default: imageName = "tokyo"
        }
        locationImageView.image = UIImage(named: imageName)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImageDetail" {
            let vc = segue.destinationViewController as! ImageDetailViewController
            vc.imageName = imageName
        }
    }
}
