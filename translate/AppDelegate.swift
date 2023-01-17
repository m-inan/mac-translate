//
//  AppDelegate.swift
//  translate
//
//  Created by Minan on 15.01.2023.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    public var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(contentRect: .zero, styleMask: [.titled, .closable, .resizable], backing: .buffered, defer: false)
        window.center()
        window.title = "Translate"
        window.contentViewController = ViewController()
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

