//
//  FloatingPanel.swift
//  translate
//
//  Created by Minan on 19.01.2023.
//

import AppKit

class FloatingPanel: NSPanel {
    public var isPresented = false
    
    required init() {
        let styleMask: StyleMask = [.nonactivatingPanel, .resizable, .titled, .closable]
        
        super.init(contentRect: .zero, styleMask: styleMask, backing: .buffered, defer: false)
        
        level = .floating
        isFloatingPanel = true
        contentViewController = ViewController()
        
        center()
        
        standardWindowButton(.closeButton)?.isHidden = true
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true
    }
    
    public func toggle() {
        let controller = contentViewController as! ViewController
        
        if !controller.isReady {
            return
        }
        
        isPresented = !isPresented
        
        if isPresented {
            makeKeyAndOrderFront(nil)
        } else {
            close()
        }
    }
    
    override func close() {
        super.close()
        isPresented = false
    }
}
