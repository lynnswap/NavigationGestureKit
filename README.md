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

## Apps Using

<p float="left">
    <a href="https://apps.apple.com/jp/app/tweetpd/id1671411031"><img src="https://i.imgur.com/AC6eGdx.png" width="65" height="65"></a>
</p>

## License
Distributed under the MIT License. See `LICENSE` for details.
