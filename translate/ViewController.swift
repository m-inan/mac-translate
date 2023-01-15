//
//  ViewController.swift
//  translate
//
//  Created by Minan on 15.01.2023.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 40))
        text.stringValue = "No Storyboard View"
        text.isEditable = false
        text.drawsBackground = false
        text.isBezeled = false
        text.font = NSFont.systemFont(ofSize: 30)
        text.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
       
        NSLayoutConstraint(item: text, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: text, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
    }
}

