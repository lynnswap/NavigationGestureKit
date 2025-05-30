# NavigationGestureKit

NavigationGestureKit is a lightweight Swift package that adds full‑width swipe‑back gestures to UINavigationController and WKWebView. A SwiftUI ViewModifier is included, so you can adopt it in both UIKit and SwiftUI projects with just a few lines of code.

## Features
- `NavigationBackSwipeHandler` enables a full-width back swipe for `UINavigationController` stacks.
- `WebViewFullWidthBackSwipeHandler` allows full-width swipe gestures in `WKWebView`.

## Usage
### SwiftUI
```swift
import SwiftUI
import NavigationGestureKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle("Home")
                .navigationBackSwipeHandler()
        }
    }
}
```
### UIKit
```swift
import NavigationGestureKit

class RootViewController: UIViewController {
    private let backSwipe = NavigationBackSwipeHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        backSwipe.configure(for: self)
    }
}
```

## License
Distributed under the MIT License. See `LICENSE` for details.
