//
//  FloatingPanel.swift
//  translate
//
//  Created by Minan on 19.01.2023.
//

import AppKit

class FloatingPanel: NSPanel {
    public var isPresented = false
    public var isDragged = false
    
    required init() {
        let styleMask: StyleMask = [.nonactivatingPanel, .resizable, .titled, .closable]
        
        super.init(contentRect: .zero, styleMask: styleMask, backing: .buffered, defer: false)
        
        level = .floating
        isFloatingPanel = true
        isMovableByWindowBackground = true
        contentViewController = ViewController()
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        backgroundColor = .clear
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        
        contentView?.wantsLayer = true
        contentView?.layer?.cornerRadius = 16
        
        standardWindowButton(.closeButton)?.isHidden = true
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true
        
        self.styleMask.insert(.fullSizeContentView)
        
        center()
    }
    
    public func toggle() {
        let controller = contentViewController as! ViewController
        
        if !controller.isReady {
            return
        }
        
        if isPresented {
            if isKeyWindow {
                isPresented = false
                close()
            } else {
                makeKey()
                controller.focusAndSelectField()
            }
        } else {
            isPresented = true
            makeKeyAndOrderFront(nil)
            controller.focusAndSelectField()
        }
    }
    
    override func close() {
        super.close()
        isPresented = false
    }
    
    override func performDrag(with event: NSEvent) {
        super.performDrag(with: event)
        isDragged = true
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        if (isDragged) {
            let controller = contentViewController as! ViewController
            controller.focusAndSelectField()
            isDragged = false
        }
    }
}
