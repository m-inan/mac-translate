//
//  AppDelegate.swift
//  translate
//
//  Created by Minan on 15.01.2023.
//

import Cocoa
import HotKey

class AppDelegate: NSObject, NSApplicationDelegate {

    public var panel: FloatingPanel!
    public var hotKey: HotKey? {
        didSet {
            guard let hotKey = hotKey else {
                return
            }
            
            hotKey.keyDownHandler = { [weak self] in
                self?.panel.toggle()
            }
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        panel = FloatingPanel()
        
        // Setup hot key for control+space
        hotKey = HotKey(key: .space, modifiers: [.control])
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

