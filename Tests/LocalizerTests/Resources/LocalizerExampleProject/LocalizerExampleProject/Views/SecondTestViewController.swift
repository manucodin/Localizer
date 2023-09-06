//
//  SecondTestViewController.swift
//  LocalizerExampleProject
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import UIKit

class SecondTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test1 = "test1".localized()
        let test2 = NSLocalizedString("test2", comment: "").uppercased()
        
        let number = 0
        var test3: String
        if number == 0 {
            test3 = NSLocalizedString("test3", comment: "")
        } else {
            test3 = ""
        }
        
        var test4 = "test4".localized()
        
        let test5 = "test_5".localized()
        let test6 = "test_6_".localized()
        let test7 = "test \"test\" 7".localized()
        
        let test8 = "test8".localized()
    }
}

