//
//  RegistrationController.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 12/03/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    let selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24, height: 44)
        textField.placeholder = "Enter full name"
        textField.backgroundColor = .white
        return textField
    }()
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24, height: 44)
        textField.placeholder = "Enter email address"
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        return textField
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24, height: 44)
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        return button
    }()
    
    lazy var layoutStackView = UIStackView(arrangedSubviews: [
        selectButton,
        fullNameTextField,
        emailTextField,
        passwordTextField,
        registerButton
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupStackView()
        setupNotificationObserver()
        setupTapGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setupGradientLayer(){
        let layer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.locations = [0,1]
        view.layer.addSublayer(layer)
        layer.frame = view.bounds
    }
    
    fileprivate func setupStackView() {
        view.addSubview(layoutStackView)
        layoutStackView.axis = .vertical
        layoutStackView.spacing = 8
        layoutStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        layoutStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupTapGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    fileprivate func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension RegistrationController {
    
    @objc fileprivate func showKeyboard(notification: NSNotification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let bottomSpace = view.frame.height - layoutStackView.frame.origin.y - layoutStackView.frame.height
        
        let difference = keyboardValue.cgRectValue.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 10)
    }
    
    @objc fileprivate func hideKeyboard(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc func handleTapDismiss(){
        view.endEditing(true)
    }
}
