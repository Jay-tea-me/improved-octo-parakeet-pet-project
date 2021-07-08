//
//  AppView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/08.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject var authService:  AuthenticationService
    init() {
        UITabBar.setTransparentTabber()
    }
    var body: some View {
        TabView {
            GeoMessageListView(geoMessageListViewModel: GeoMessageListViewModel())
                .tabItem {
                    Image(systemName: "camera")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                .environmentObject(authService)
        }
    }
}


