//
//  ViewController.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 25/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topStackView = TopStackView()
    let bottomStackView = BottomStackView()
    let middleView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        middleView.backgroundColor = .black
        setupUI()
    }
    
    
    fileprivate func setupUI(){
        let fullScreenStackView = UIStackView(arrangedSubviews: [topStackView, middleView, bottomStackView])
        fullScreenStackView.axis = .vertical
        view.addSubview(fullScreenStackView)
        fullScreenStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }

}

