//
//  SigninController.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/16.
//

import UIKit
import SwiftUI
import GoogleSignIn

final class SignInViewController: UIViewController {
    private lazy var authService = GoogleAuth()

    override func viewDidLoad() {
        super.viewDidLoad()

        let signInButton = GIDSignInButton()
        signInButton.colorScheme = .dark
        signInButton.addTarget(self, action: #selector(singInButtonPressed), for: .touchUpInside)

        self.view.addSubview(signInButton)
    }

    @objc func singInButtonPressed(sender: UIButton) {
        _ = authService.signIn()
    }

}

struct IntegratedSignInViewController: UIViewControllerRepresentable {
    // swiftlint:disable line_length
    func makeUIViewController(context: UIViewControllerRepresentableContext<IntegratedSignInViewController>) -> SignInViewController {
        let controller = SignInViewController()
        return controller
    }

    func updateUIViewController(_ uiViewController: SignInViewController, context: UIViewControllerRepresentableContext<IntegratedSignInViewController>) {}

}
