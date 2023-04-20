//
//  Constants.swift
//  translate
//
//  Created by Minan on 21.01.2023.
//

import Foundation
import AppKit
import HotKey

struct Constants {
    static let WIDTH = 600
    static let HEIGHT = 334
    
    static let SOURCE_LANGUAGE = "en"
    static let TRANSLATION_LANGUAGE = "tr"
    
    static let key: Key = .backslash
    static let modifiers: NSEvent.ModifierFlags = [.command]
}
