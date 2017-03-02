//
//  CasperSplashWebView.swift
//  CasperSplash
//
//  Created by ftiff on 04/08/16.
//  Copyright © 2016 François Levaux-Tiffreau. All rights reserved.
//

import Cocoa
import WebKit

class CasperSplashWebView: WebView {

    override func viewWillDraw() {
        self.layer?.borderWidth = 1.0
        self.layer?.borderWidth = 1.0
        self.layer?.borderColor = NSColor.lightGray.cgColor
        self.layer?.isOpaque = true
        
        
        // An attempt at returning a localized version, if exists.
        // presentation.html -> presentation_fr.html
        
        if let indexHtmlPath = Preferences.sharedInstance.htmlAbsolutePath {
            let full_url = URL(fileURLWithPath: indexHtmlPath)
            let extension_path = full_url.pathExtension
            let base_path = full_url.deletingPathExtension().path
            let languageCode = NSLocale.current.languageCode ?? "en"
            
            let localized_path = "\(base_path)_\(languageCode).\(extension_path)"
            
            if FileManager().fileExists(atPath: localized_path) {
                self.mainFrame.load(URLRequest(url: URL(fileURLWithPath: localized_path)))
            } else {
                self.mainFrame.load(URLRequest(url: URL(fileURLWithPath: indexHtmlPath)))
            }
        } else {
            NSLog("Cannot get HTML Path!")
        }
    }
}
