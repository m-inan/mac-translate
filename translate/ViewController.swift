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
    var visualEffect: NSVisualEffectView!
    
    var isDarkMode: Bool {
        let mode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
        return mode == "Dark"
    }
    
    override func loadView() {
        webView = WebView(frame: NSRect(x: 0, y: 0, width: 600, height: 334))
        webView.navigationDelegate = self
        
        let url = URL(string: "https://translate.google.com/?sl=en&tl=tr")!
        webView.load(URLRequest(url: url))
        
        webView.wantsLayer = true
        webView.layer?.backgroundColor = .clear
        webView.setValue(false, forKey: "drawsBackground")
        
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DistributedNotificationCenter.default.addObserver(
            forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
            object: nil,
            queue: OperationQueue.main
        ) { [weak self] _ in
            self?.setTheme()
        }
        
        visualEffect = NSVisualEffectView(frame: self.view.bounds)
        visualEffect.state = .active
        visualEffect.material = .dark
        visualEffect.blendingMode = .behindWindow
        visualEffect.autoresizingMask = [.width, .height]
        
        self.view.addSubview(visualEffect, positioned: .below, relativeTo: nil)
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
        
            var theme = document.createElement("style");
            theme.setAttribute("id", "theme-style");
            document.body.appendChild(theme);
        """)
        
        self.setTheme()
        
        isReady = true
    }
    
    func setTheme() {
        visualEffect.material = isDarkMode ? .dark : .light
        
        let color = isDarkMode ? "white": "black"
        
        self.webView.evaluateJavaScript("""
            theme.innerHTML = `
                *, *:before, *:after {
                    background: transparent !important;
                    color: \(color) !important;
                    box-shadow: none !important;
                    border-color: \(color) !important;
                }
                
                .zXU7Rb, .ccvoYb.EjH7wc {
                    border: none !important;
                }
            `;
        """)
    }
}
