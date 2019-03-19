//
//  Bindable.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 19/03/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
