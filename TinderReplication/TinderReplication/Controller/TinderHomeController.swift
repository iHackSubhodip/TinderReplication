//
//  ViewController.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 25/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit
import Firebase

class MiddleUIView: UIView{ }

class TinderHomeController: UIViewController {

    let topStackView = TopStackView()
    let bottomStackView = BottomStackView()
    let middleCardView = MiddleUIView()
    
//    let usersCard: [TinderCardViewModel] = {
//        let producer = [
//            UserModel(name: "Jane", age: 26, profession: "SDE", imageNames: ["jane1", "jane2", "jane3"]),
//            AdvertiserModel(tittle: "Riju", posterImageName: "0", brandname: "SDE")
//            ] as [TinderCardViewModelProtocol]
//
//        let cardViewModel = producer.map ({
//            return $0.convertToCardViewModel()
//        })
//        return cardViewModel
//    }()
    
    var usersCardViewModel = [TinderCardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        fetchFromFirestore()
    }
    
    fileprivate func setupCardView(){
        usersCardViewModel.forEach { (user) in
            let cardView = MiddleCardView(frame: .zero)
            cardView.cardViewModel = user
            middleCardView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupStackView(){
        view.backgroundColor = .white
        let fullScreenStackView = UIStackView(arrangedSubviews: [topStackView, middleCardView, bottomStackView])
        fullScreenStackView.axis = .vertical
        view.addSubview(fullScreenStackView)
        fullScreenStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        fullScreenStackView.isLayoutMarginsRelativeArrangement = true
        fullScreenStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        fullScreenStackView.bringSubviewToFront(middleCardView)
    }
    
    fileprivate func fetchFromFirestore(){
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("error is: ", err)
                return
            }
            snapshot?.documents.forEach({ (documentSnapShot) in
                let dataDictionary = documentSnapShot.data()
                let user = UserModel(dataDictionary)
                self.usersCardViewModel.append(user.convertToCardViewModel())
            })
            self.setupCardView()
        }
    }

}

