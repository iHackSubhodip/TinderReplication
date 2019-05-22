//
//  BottomStackView.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 26/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class BottomStackView: UIStackView{
    
    static func createButton(_ image: UIImage) -> UIButton{
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    let refreshButton = createButton(#imageLiteral(resourceName: "refresh_circle"))
    let dislikeButton = createButton(#imageLiteral(resourceName: "dismiss_circle"))
    let superLikeButton = createButton(#imageLiteral(resourceName: "super_like_circle"))
    let likeButton = createButton(#imageLiteral(resourceName: "like_circle"))
    let specialButton = createButton(#imageLiteral(resourceName: "boost_circle"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        [refreshButton, dislikeButton, superLikeButton, likeButton, specialButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
//        let buttonSubviews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
//            let buttons = UIButton(type: .system)
//            buttons.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
//            return buttons
//        }
//
//        buttonSubviews.forEach { (view) in
//            addArrangedSubview(view)
//        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
