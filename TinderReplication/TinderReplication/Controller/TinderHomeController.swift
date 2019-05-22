//
//  ViewController.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 25/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class MiddleUIView: UIView{ }

class TinderHomeController: UIViewController {

    let topStackView = TopStackView()
    let bottomStackView = BottomStackView()
    let middleCardView = MiddleUIView()
    var lastFetchUser: UserModel?
    var usersCardViewModel = [TinderCardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        fetchFromFirestore()
        setupFirestoreUserCards()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        bottomStackView.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
    }
    
    fileprivate func setupFirestoreUserCards() {
        usersCardViewModel.forEach { (cardVM) in
            let cardView = MiddleCardView(frame: .zero)
            cardView.cardViewModel = cardVM
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
    
    @objc fileprivate func handleSettings(){
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
    }
    
    @objc fileprivate func handleRefresh(){
        fetchFromFirestore()
    }
    
    
    fileprivate func fetchFromFirestore(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Fetching Users"
        hud.show(in: view)
        let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchUser?.uid ?? ""]).limit(to: 2)
        
        query.getDocuments { (snapshot, err) in
            hud.dismiss()
            if let err = err {
                print("error is: ", err)
                return
            }
            snapshot?.documents.forEach({ (documentSnapShot) in
                let dataDictionary = documentSnapShot.data()
                let user = UserModel(dataDictionary)
                self.usersCardViewModel.append(user.convertToCardViewModel())
                self.lastFetchUser = user
                self.setupCardFromUser(user: user)
            })
            
        }
    }
    
    fileprivate func setupCardFromUser(user: UserModel){
        let cardView = MiddleCardView(frame: .zero)
        cardView.cardViewModel = user.convertToCardViewModel()
        middleCardView.addSubview(cardView)
        middleCardView.sendSubviewToBack(cardView)
        cardView.fillSuperview()
    }

}

