//
//  AppView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/08.
//

import SwiftUI
import CoreLocation

struct LandingView: View {

    var body: some View {
        CustomTabView(
            tabBarItem: [ "message", "globe", "person"],
            text: [Text("Messages"), Text("Map"), Text("Profile")],
            content: [
                AnyView(GeoMessageListView(geoMessageListViewModel: GeoMessageListViewModel())),
                AnyView(MapView()),
                AnyView(ProfileView())]
        )
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .preferredColorScheme(.dark)

    }
}
