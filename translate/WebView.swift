//
//  WebView.swift
//  translate
//
//  Created by Minan on 18.01.2023.
//

import WebKit

class WebView: WKWebView {
    private let commandKey = NSEvent.ModifierFlags.command.rawValue
        
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        if event.type == NSEvent.EventType.keyDown {
            if (event.modifierFlags.rawValue & NSEvent.ModifierFlags.deviceIndependentFlagsMask.rawValue) == commandKey {
                switch event.charactersIgnoringModifiers! {
                case "z":
                    if NSApp.sendAction(Selector(("undo:")), to: nil, from: self) { return true }
                case "r":
                    if NSApp.sendAction(Selector(("redo:")), to: nil, from: self) { return true }
                case "x":
                    if NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: self) { return true }
                case "c":
                    if NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: self) { return true }
                case "v":
                    if NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: self) { return true }
                case "a":
                    if NSApp.sendAction(#selector(NSResponder.selectAll(_:)), to: nil, from: self) { return true }
                default:
                break
                }
            }
        }
        
        return super.performKeyEquivalent(with: event)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.window?.performDrag(with: event)
    }
}
