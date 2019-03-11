//
//  MiddleCardView.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 26/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class MiddleCardView: UIView{
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "0"))
    fileprivate let userInformation = UILabel()
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let barStackView = UIStackView()
    fileprivate var imageIndex = 0
    
    var cardViewModel: TinderCardViewModel?{
        didSet{
            guard let imageName = cardViewModel?.imageNamesArray.first, let attributedString = cardViewModel?.attributedString, let textAlignment = cardViewModel?.textAlignment else{
                return
            }
            imageView.image = UIImage(named: imageName)
            userInformation.attributedText = attributedString
            userInformation.textAlignment = textAlignment
            let imageCount = cardViewModel?.imageNamesArray.count ?? 0
            (0..<imageCount).forEach { (_) in
                let view = UIView()
                view.backgroundColor = UIColor(white: 0, alpha: 0.1)
                barStackView.addArrangedSubview(view)
            }
            barStackView.arrangedSubviews.first?.backgroundColor = .white
            setupImageIndexObserver()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        addGesture()
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        setupBarsStackView()
        setupGradientLayer()
        setupUserInformation()
    }
    
    fileprivate func setupBarsStackView(){
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 5))
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
    }
    
    fileprivate func setupUserInformation(){
        addSubview(userInformation)
        userInformation.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        userInformation.textColor = .white
        userInformation.numberOfLines = 0
        userInformation.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    }
    
    fileprivate func setupGradientLayer(){
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1]
        layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupImageIndexObserver(){
        cardViewModel?.imageIndexObserver = { [weak self] (index, image) in
            guard let selfObject = self else { return }
            selfObject.imageView.image = image
            selfObject.barStackView.arrangedSubviews.forEach({ (view) in
                view.backgroundColor = UIColor(white: 0, alpha: 0.1)
            })
            selfObject.barStackView.arrangedSubviews[index].backgroundColor = .white
        }
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer){
        let tapLocation = gesture.location(in: nil)
        let shouldChangeToNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldChangeToNextPhoto{
            cardViewModel?.forwardToNextPhoto()
        }else{
            cardViewModel?.backwardToPreviousPhoto()
        }        
    }
    
    fileprivate func addGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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
