//
//  UIObject.swift
//  Wayangan
//
//  Created by Ahmad Fariz on 15/04/23.
//

import Foundation
import SwiftUI
import Combine

protocol MenuItem {
    var id: UUID { get }
    var title: String { get }
    var symbol : String {get}
    var destinationView : AnyView {get}
    var action: () -> Void { get }
}

struct AnyMenuItem: Identifiable {
    let id = UUID()
    let menuItem: MenuItem
    
    var title: String {
        menuItem.title
    }
    var symbol: String {
        menuItem.symbol
    }
    var destinationView: AnyView{
        menuItem.destinationView
    }
    var action: () -> Void {
        menuItem.action
    }
}
struct StoryMenuItem: MenuItem {
    let id = UUID()
    let title = "Story"
    let symbol = "theatermasks"
    let destinationView: AnyView
    let action: () -> Void
}
struct CollectionMenuItem: MenuItem {
    let id = UUID()
    let title = "Collection"
    let symbol = "globe.asia.australia.fill"
    let destinationView: AnyView
    let action: () -> Void
}
struct SettingsMenuItem: MenuItem {
    let id = UUID()
    let title = "Settings"
    let symbol = "gearshape"
    let destinationView: AnyView
    let action: () -> Void
}

struct ProfileMenuItem: MenuItem {
    let id = UUID()
    let title = "Profile"
    let symbol = "person"
    let destinationView: AnyView
    let action: () -> Void
}
