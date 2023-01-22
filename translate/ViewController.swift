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
        let width = Constants.WIDTH
        let height = Constants.HEIGHT
        let source = Constants.SOURCE_LANGUAGE
        let translation = Constants.TRANSLATION_LANGUAGE

        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: "callbackHandler")
        
        webView = WebView(frame: NSRect(x: 0, y: 0, width: width, height: height), configuration: config)
        webView.navigationDelegate = self
        
        let url = URL(string: "https://translate.google.com/?sl=\(source)&tl=\(translation)")!
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
        visualEffect.blendingMode = .behindWindow
        visualEffect.autoresizingMask = [.width, .height]
        
        self.view.addSubview(visualEffect, positioned: .below, relativeTo: nil)
    }
    
    override func keyDown(with event: NSEvent) {
        // keyDown
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
        
                html {
                    overflow: hidden
                }
                
                body::-webkit-scrollbar {
                    width: 0;
                    height: 0;
                    display: none;
                    -webkit-appearance: none;
                }
            `;
        
            document.body.appendChild(style);
        
            var theme = document.createElement("style");
            theme.setAttribute("id", "theme-style");
            document.body.appendChild(theme);
        
            document.addEventListener('keydown', function(event) {
                const keyCode = event.keyCode;
                const metaKey = event.metaKey;

                // (tab) focus last application
                if (keyCode == 9) {
                    event.preventDefault();
                    window.webkit.messageHandlers.callbackHandler.postMessage(keyCode);
                }
                
                // (cmd + l) listen source
                if (metaKey && keyCode == 76) {
                    document.querySelector(".m0Qfkd .VfPpkd-Bz112c-kBDsod:not(.VfPpkd-Bz112c-kBDsod-OWXEXe-IT5dJd)").click()
                                
                    setTimeout(function() {
                        var textarea = document.getElementsByTagName("textarea")[0];
                        textarea.focus();
                        textarea.select();
                    }, 800)
                }
                
                // (cmd + s) swap languages
                if (metaKey && keyCode == 83) {
                    document.querySelector(".U2dVxe > i").click();
                }
        
                // (cmd + enter) click did you mean text
                if (metaKey && keyCode == 13) {
                    const label = document.querySelector(".mvqA2c")
                    if (label) {
                        label.click();
                    }
                }
            })
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
    
    public func focusAndSelectField() {
        self.webView.evaluateJavaScript("""
            setTimeout(function() {
               var textarea = document.getElementsByTagName("textarea")[0];
        
                textarea.focus();
                textarea.select();
            }, 20);
        """)
    }
}

extension ViewController: WKScriptMessageHandler {
    // keydown in webkit
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let keyCode = message.body as? Int
        
        // Tab key pressed in textarea
        if (keyCode == 9) {
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.panel.resignKey()
        }
    }
}
