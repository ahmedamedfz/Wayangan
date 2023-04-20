//
//  MenuItemFactory.swift
//  Wayangan
//
//  Created by Ahmad Fariz on 15/04/23.
//

import Foundation
import SwiftUI

struct MenuItemFactory {
    static func createMenuItem(type: MenuItemType,destinationView: AnyView, action: @escaping () -> Void) -> any MenuItem {
        switch type {
        case .story:
            return StoryMenuItem(destinationView: destinationView, action: action)
        case .collection:
            return CollectionMenuItem(destinationView: destinationView, action: action)
        case .settings:
            return SettingsMenuItem(destinationView: destinationView, action: action)
        case .profile:
            return ProfileMenuItem(destinationView: destinationView, action: action)
        }
    }
}


