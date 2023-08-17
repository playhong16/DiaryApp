//
//  TabBarViewController.swift
//  DiaryApp
//
//  Created by playhong on 2023/08/16.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .creamYellow
        tabBar.barTintColor = .customYellow
        tabBar.backgroundColor = .customYellow
        tabBar.unselectedItemTintColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.customYellow.cgColor
    }
    
}

