<h1 align="center">Mac Translate</h1>

<div align="center">
  <img src="https://github.com/m-inan/mac-translate/blob/main/media/256.png?raw=true" />
</div>

<p align="center">
  Google Translate in Mac App like Spotlight
</p>

![](https://github.com/m-inan/mac-translate/blob/main/media/mac-translate-app.jpg?raw=true)

## Download

#### [Click To Download](https://github.com/m-inan/mac-translate/releases/download/1.0.0/translate.zip). If it gives an error when you try to open the application:
 
Go to `System Preferences > Security & Privacy` and there should be a button saying `Open Anyway`,  under the `Security` .

## Configuration

	
```swift
// Constants.swift
struct Constants {
    static let WIDTH = 600
    static let HEIGHT = 334
    static let SOURCE_LANGUAGE = "en" 
    static let TRANSLATION_LANGUAGE = "tr"
    static let key: Key = .backslash
    static let modifiers: NSEvent.ModifierFlags = .command
}
```

## Keybindings

| Shortcuts                                   | Functionality        |
| ------------------------------------------- | -------------------- |
| `ESC`                     			      | Hide Panel           |
| `Tab`                     			      | Focus Last App       |
| `CMD + /`                     			  | Toggle Panel - Focus |
| `CMD + L`                     			  | Listen Source        |
| `CMD + S`                     			  | Swap Languages       |
| `CMD + Enter`                     		  | Fix Typo             |

### Reporting Issues
If believe you've found an issue, please [report it](https://github.com/m-inan/mac-translate/issues) along with any relevant details to reproduce it.

### Asking for help 
Please do not use the issue tracker for personal support requests. Instead, use StackOverflow.

### Contributions 
Yes please! Feature requests / pull requests are welcome.
