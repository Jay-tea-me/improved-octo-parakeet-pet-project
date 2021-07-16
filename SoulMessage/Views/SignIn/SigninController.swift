//
//  SigninController.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/16.
//

import UIKit
import SwiftUI
import GoogleSignIn

class SignInController: UIViewController {
    var signInViewModel: SignInViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let signInButton = GIDSignInButton()
        signInButton.colorScheme = .dark
        signInButton.addTarget(self, action: #selector(singInButtonPressed), for: .touchUpInside)
        self.view.addSubview(signInButton)
        
    }
    
    @objc func singInButtonPressed(sender: UIButton){
        signInViewModel.signin()
    }
    
}

struct IntegratedSignInController: UIViewControllerRepresentable {
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<IntegratedSignInController>) -> SignInController {
        let controller = SignInController()
        controller.signInViewModel = signInViewModel
        return controller
        
    }
    
    
    func updateUIViewController(_ uiViewController: SignInController, context: UIViewControllerRepresentableContext<IntegratedSignInController>) {
        
    }
    
    
}
