//
//  OrderBelowBugVenturaApp.swift
//  OrderBelowBugVentura
//
//  Created by Guillaume Leclerc on 15/07/2022.
//

import SwiftUI

@main
struct OrderBelowBugVenturaApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var window: NSWindow = {
        let window = NSWindow(contentRect: NSRect(), styleMask: [], backing: .buffered, defer: true)
        
        window.backgroundColor = .black
        window.ignoresMouseEvents = true
        window.collectionBehavior = [.transient]
        
        return window
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView(window: window)
        }
    }
}
