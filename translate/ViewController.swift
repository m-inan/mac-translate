//
//  ViewController.swift
//  translate
//
//  Created by Minan on 15.01.2023.
//

import Cocoa
import WebKit


class ViewController: NSViewController, WKNavigationDelegate {
    public var isReady = false
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WebView(frame: NSRect(x: 0, y: 0, width: 600, height: 334))
        webView.navigationDelegate = self
        
        let url = URL(string: "https://translate.google.com/?sl=en&tl=tr")!
        webView.load(URLRequest(url: url))
        
        self.view = webView
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // disable google translate autocomplete and remove ui elements
        self.webView.evaluateJavaScript("""
            const style = document.createElement("style");
        
            style.innerHTML = `
                header,
                #kvLWu,
                .VjFXz,
                .VlPnLc,
                .gp-footer,
                .hgbeOc.EjH7wc,
                .feedback-link,
                [aria-haspopup] {
                    display: none !important
                }
            `;
        
            document.body.appendChild(style);
        """)
        
        isReady = true
    }
}
