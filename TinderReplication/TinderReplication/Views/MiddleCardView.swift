//
//  MiddleCardView.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 26/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class MiddleCardView: UIView{
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "0"))
    let userInformation = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        setupUserInformation()
        addGesture()
    }
    
    fileprivate func setupUserInformation(){
        addSubview(userInformation)
        userInformation.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        userInformation.textColor = .white
        userInformation.numberOfLines = 0
        userInformation.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    }
    
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    
    fileprivate func addGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > 80
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard{
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            }else{
                self.transform = .identity
            }
        }) { _ in
            self.transform = .identity
            if shouldDismissCard{
                self.removeFromSuperview()
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
