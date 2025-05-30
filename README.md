# NavigationGestureKit

A Swift package that expands navigation back swipe gestures to the full width of the view. Designed with SwiftUI in mind, it lets you enable system-like back navigation across your entire screen.

## Features
- `NavigationBackSwipeHandler` enables a full-width back swipe for `UINavigationController` stacks.
- `WebViewFullWidthBackSwipeHandler` allows full-width swipe gestures in `WKWebView`.

## SwiftUI Usage
```swift
import SwiftUI
import NavigationGestureKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle("Home")
        }
        .navigationBackSwipeHandler()
    }
}
```

## License
Distributed under the MIT License. See `LICENSE` for details.
