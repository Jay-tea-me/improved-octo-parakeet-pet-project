//
//  TabStyle.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/08.
//

import SwiftUI

extension UITabBarController {
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()
        standardAppearance.selectionIndicatorTintColor = .green
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        standardAppearance.inlineLayoutAppearance = tabBarItemAppearance
        standardAppearance.stackedLayoutAppearance = tabBarItemAppearance
        standardAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        tabBar.standardAppearance = standardAppearance
    }

}

extension UITabBar {
    static func setTransparentTabber() {
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().tintColor = .green
    }
    
}

