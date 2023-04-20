//
//  MenuViewModel.swift
//  Wayangan
//
//  Created by Ahmad Fariz on 15/04/23.
//

import Foundation
import SwiftUI
import Combine

class MenuViewModel: ObservableObject {
    @Published var menuItems: [AnyMenuItem] = []

    func loadMenuItems() {
        menuItems = [
            AnyMenuItem(menuItem:MenuItemFactory.createMenuItem(type: .story, destinationView: AnyView(StoryView().environmentObject(PassGameDialogueAndClueData()))) { print("Story selected") }),
            AnyMenuItem(menuItem:MenuItemFactory.createMenuItem(type: .collection, destinationView: AnyView(CollectionView())) { print("Collection selected") }),
            AnyMenuItem(menuItem:MenuItemFactory.createMenuItem(type: .settings,destinationView: AnyView(SettingView())) { print("Settings selected") }),
            AnyMenuItem(menuItem: MenuItemFactory.createMenuItem(type: .profile, destinationView: AnyView(ProfileView())) { print("Profile selected") })
        ]
    }
}

enum MenuItemType {
    case story
    case collection
    case settings
    case profile
}
