//
//  RegistrationViewModel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 19/03/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class RegistrationViewModel{
    
    var fullName: String? { didSet{ checkFormValidity() } }
    var emailAddress: String? { didSet{ checkFormValidity() } }
    var passowrdField: String? { didSet{ checkFormValidity() } }
    
    var isFormValidObserver: ((Bool) -> ())?
    
    fileprivate func checkFormValidity(){
        let isFormValid = fullName?.isEmpty == false && emailAddress?.isEmpty == false && passowrdField?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
}
