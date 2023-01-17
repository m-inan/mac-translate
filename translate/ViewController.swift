//
//  ViewController.swift
//  translate
//
//  Created by Minan on 15.01.2023.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
        
        let url = URL(string: "https://translate.google.com/?sl=en&tl=tr&op=translate")!
        webView.load(URLRequest(url: url))
        
        self.view = webView
    }
}
