//
//  TinderCardViewModel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 27/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class TinderCardViewModel{
    
    let imageNamesArray: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    fileprivate var imageIndex = 0{
        didSet{
            let imageName = imageNamesArray[imageIndex]
            imageIndexObserver?(imageIndex, imageName)
        }
    }
    var imageIndexObserver: ((Int, String) -> ())?
    
    init(imageNamesArray: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment){
        self.imageNamesArray = imageNamesArray
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    func forwardToNextPhoto(){
        imageIndex = min(imageIndex + 1, imageNamesArray.count - 1)
    }
    
    func backwardToPreviousPhoto(){
        imageIndex = max(0, imageIndex - 1)
    }
}

protocol TinderCardViewModelProtocol{
    func convertToCardViewModel() -> TinderCardViewModel
}
