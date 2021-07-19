//
//  SignOutViewController.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/16.
//

import Foundation
import UIKit
import SwiftUI

final class SignOutViewController: UIViewController {
    private lazy var authService = GoogleAuth()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signOutButton =  UIButton(type: .system)
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.frame = CGRect(x: 100, y: 0, width: 200, height: 100)
        signOutButton.addTarget(self, action: #selector(singOutButtonPressed), for: .touchUpInside)

        self.view.addSubview(signOutButton)
    }
    
    @objc func singOutButtonPressed(sender: UIButton){
        let _ = authService.signOut()
    }
    
}

struct IntegratedSignOutController: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<IntegratedSignOutController>) -> SignOutViewController {
        let controller = SignOutViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SignOutViewController, context: UIViewControllerRepresentableContext<IntegratedSignOutController>) {}
    
}
