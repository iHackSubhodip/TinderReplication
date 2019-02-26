//
//  ViewController.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 25/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class TinderHomeController: UIViewController {

    let topStackView = TopStackView()
    let bottomStackView = BottomStackView()
    let middleCardView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupCardView()
    }
    
    fileprivate func setupCardView(){
        (0..<6).forEach { (_) in
            let cardView = MiddleCardView(frame: .zero)
            middleCardView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupStackView(){
        let fullScreenStackView = UIStackView(arrangedSubviews: [topStackView, middleCardView, bottomStackView])
        fullScreenStackView.axis = .vertical
        view.addSubview(fullScreenStackView)
        fullScreenStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        fullScreenStackView.isLayoutMarginsRelativeArrangement = true
        fullScreenStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        fullScreenStackView.bringSubviewToFront(middleCardView)
    }

}

