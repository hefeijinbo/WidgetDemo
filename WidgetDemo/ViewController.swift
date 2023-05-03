//
//  ViewController.swift
//  WidgetDemo
//
//  Created by jinbo on 2023/5/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func weightAction(_ sender: Any) {
        AppGroupUtil.saveWeight(value: String(arc4random_uniform(100)) + "kg")
    }
    
    @IBAction func heightAction(_ sender: Any) {
        AppGroupUtil.saveHeight(value: String(arc4random_uniform(200)) + "cm")
    }
    
    @IBAction func clearAction(_ sender: Any) {
        AppGroupUtil.clearAllValues()
    }
    
}

