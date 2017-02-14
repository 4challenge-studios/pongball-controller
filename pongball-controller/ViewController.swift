//
//  ViewController.swift
//  pongball-controller
//
//  Created by Matheus Martins on 2/9/17.
//  Copyright © 2017 matheusmcardoso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rightClick(sender: AnyObject) {
        print("right")

    }
    
    @IBAction func leftClick(sender: AnyObject) {
        print("left")
    }
}

