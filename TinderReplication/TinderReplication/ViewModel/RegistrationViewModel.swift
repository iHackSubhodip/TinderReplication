//
//  RegistrationViewModel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 19/03/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel{
    
    var fullName: String? { didSet{ checkFormValidity() } }
    var emailAddress: String? { didSet{ checkFormValidity() } }
    var passwordField: String? { didSet{ checkFormValidity() } }
    
    var bindableImage = Bindable<UIImage>()
    var bindableForm = Bindable<Bool>()
    var isRegistering = Bindable<Bool>()
    
    fileprivate func checkFormValidity(){
        let isFormValid = fullName?.isEmpty == false && emailAddress?.isEmpty == false && passwordField?.isEmpty == false
        bindableForm.value = isFormValid
    }
    
    func performRegistration(completion: @escaping (Error?) -> ()){
        guard let email = emailAddress, let password = passwordField else { return }
        isRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let err = err {
                completion(err)
                return
            }
            let reference = Storage.storage().reference(withPath: "/images/\(UUID().uuidString)")
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            DispatchQueue.main.async{
                reference.putData(imageData, metadata: nil, completion: { (_, err) in
                    if let err = err{
                        completion(err)
                        return
                    }
                    reference.downloadURL(completion: { (url, err) in
                        if let err = err{
                            completion(err)
                            return
                        }
                        self.isRegistering.value = false
                    })
                })
            }
        }
    }
}
