//
//  AppView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/08.
//

import SwiftUI
import CoreLocation

struct LandingView: View {
    @EnvironmentObject var signInViewModel:  SignInViewModel
    init() {
        UITabBar.setTransparentTabber()
    }
    var body: some View {
        CustomTabView(
            tabBarItem: [ "message", "globe", "person"],
            text: [Text("Messages"), Text("Map"), Text("Profile")],
            content:[AnyView(GeoMessageListView(geoMessageListViewModel: GeoMessageListViewModel())), AnyView(MapView(coordinate: CLLocationCoordinate2D(latitude: 28.076_783, longitude: -26.198_223))),
                     AnyView(ProfileView())]
        )
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .preferredColorScheme(.dark)
            .environmentObject(SignInViewModel(authenticationService: GoogleAuth()))
    }
}


