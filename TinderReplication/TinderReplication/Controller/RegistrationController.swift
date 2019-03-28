//
//  RegistrationController.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 12/03/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationController: UIViewController {

    let selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleImageSelection), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24, height: 44)
        textField.placeholder = "Enter full name"
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(handleTextChang), for: .editingChanged)
        return textField
    }()
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24, height: 44)
        textField.placeholder = "Enter email address"
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(handleTextChang), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 24, height: 44)
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(handleTextChang), for: .editingChanged)
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleRegisterTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField,
            registerButton
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var overallLayoutStackView = UIStackView(arrangedSubviews: [
        selectButton,
        verticalStackView
        ])
    
    fileprivate let layer = CAGradientLayer()
    lazy var selectPhotoButtonWidthAnchor = selectButton.widthAnchor.constraint(equalToConstant: 275)
    lazy var selectPhotoButtonHeightAnchor = selectButton.heightAnchor.constraint(equalToConstant: 275)
    let registrationViewModel = RegistrationViewModel()
    let registerHUD = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupStackView()
        setupTapGesture()
        registrationViewModelObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layer.frame = view.bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.verticalSizeClass == .compact{
            overallLayoutStackView.axis = .horizontal
            verticalStackView.distribution = .fillEqually
            selectPhotoButtonWidthAnchor.isActive = true
            selectPhotoButtonHeightAnchor.isActive = false
        }else{
            overallLayoutStackView.axis = .vertical
            verticalStackView.distribution = .fill
            selectPhotoButtonWidthAnchor.isActive = false
            selectPhotoButtonHeightAnchor.isActive = true
        }
    }
    
    fileprivate func setupGradientLayer(){
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.locations = [0,1]
        view.layer.addSublayer(layer)
        layer.frame = view.bounds
    }
    
    fileprivate func setupStackView() {
        view.addSubview(overallLayoutStackView)
        overallLayoutStackView.axis = .vertical
        overallLayoutStackView.spacing = 8
        overallLayoutStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        overallLayoutStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupTapGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    fileprivate func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func registrationViewModelObserver(){
        
        registrationViewModel.bindableForm.bind { [weak self] (isFormValid) in
            guard let selfObject = self, let isValidForm = isFormValid else { return }
            selfObject.registerButton.isEnabled = isValidForm
            if isValidForm{
                selfObject.registerButton.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
                selfObject.registerButton.setTitleColor(.white, for: .normal)
            }else{
                selfObject.registerButton.backgroundColor = .lightGray
                selfObject.registerButton.setTitleColor(.gray, for: .disabled)
            }
        }
        
        registrationViewModel.bindableImage.bind { [weak self] (image) in
            guard let selfObject = self else { return }
            selfObject.selectButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        registrationViewModel.isRegistering.bind { [weak self] (isRegistering) in
            guard let selfObject = self else { return }
            if isRegistering == true{
                selfObject.registerHUD.textLabel.text = "Register"
                selfObject.registerHUD.show(in: selfObject.view)
            }else{
                selfObject.registerHUD.dismiss()
            }
        }
    }
    
    fileprivate func showError(error: Error){
        registerHUD.dismiss()
        let progressBar = JGProgressHUD(style: .dark)
        progressBar.textLabel.text = "Failed with Error"
        progressBar.detailTextLabel.text = error.localizedDescription
        progressBar.show(in: self.view)
        progressBar.dismiss(afterDelay: 4)
    }
    
}

extension RegistrationController {
    
    @objc fileprivate func showKeyboard(notification: NSNotification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let bottomSpace = view.frame.height - overallLayoutStackView.frame.origin.y - overallLayoutStackView.frame.height
        
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
    
    @objc func handleTextChang(textField: UITextField){
        if textField == fullNameTextField{
            registrationViewModel.fullName = textField.text
        }else if textField == emailTextField{
            registrationViewModel.emailAddress = textField.text
        }else{
            registrationViewModel.passwordField = textField.text
        }
    }
    
    @objc fileprivate func handleRegisterTapped(){
        self.handleTapDismiss()
        registrationViewModel.performRegistration { [weak self] (err) in
            guard let selfObject = self else { return }
            if let err = err{
                selfObject.showError(error: err)
                return
            }
        }
        
    }
    
    @objc fileprivate func handleImageSelection(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registrationViewModel.bindableImage.value = image
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
