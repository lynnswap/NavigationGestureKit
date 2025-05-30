//
//  WebViewFullWidthBackSwipeHandler.swift
//  NavigationGestureKit
//
//  Created by lynnswap on 2025/05/30.
//

import UIKit
import WebKit
import ObjectiveC

@MainActor
public final class WebViewFullWidthBackSwipeHandler: NSObject {
    public func configure(for webView: WKWebView,
                          gestureName: String = NavigationGestureKit.defaultFullWidthBackGestureName) {
        self.webView = webView
        guard let edgePan = webView.gestureRecognizers?.first(where: { $0 is UIScreenEdgePanGestureRecognizer }),
              let targets = edgePan.value(forKey: "targets") as? [NSObject]
        else { return }

        panGesture.setValue(targets, forKey: "targets")
        panGesture.delegate = self
        panGesture.name = gestureName
        webView.addGestureRecognizer(panGesture)
    }

    private weak var webView: WKWebView?
    private let panGesture = UIPanGestureRecognizer()
}

extension WebViewFullWidthBackSwipeHandler: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gesture: UIGestureRecognizer) -> Bool {
        guard let view = webView,
              let pan = gesture as? UIPanGestureRecognizer
        else { return false }
        
        let loc   = pan.location(in: view).x
        let width = view.bounds.width
        let ignoreZone = min(width * 0.15, 120)
        return loc < (width - ignoreZone)
    }
}

// MARK: - WKWebView extension
private var fullWidthHandlerKey: UInt8 = 0

public extension WKWebView {
    /// Installs and returns a ``WebViewFullWidthBackSwipeHandler`` for this web view.
    /// The handler is created only once and stored via Objective-C associated objects.
    var fullWidthBackSwipeHandler: WebViewFullWidthBackSwipeHandler {
        if let handler = objc_getAssociatedObject(self, &fullWidthHandlerKey) as? WebViewFullWidthBackSwipeHandler {
            return handler
        }
        let handler = WebViewFullWidthBackSwipeHandler()
        handler.configure(for: self, gestureName: NavigationGestureKit.defaultFullWidthBackGestureName)
        objc_setAssociatedObject(self, &fullWidthHandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return handler
    }

    /// Adds a full-width back swipe handler with an optional gesture name.
    /// - Parameter gestureName: The identifier assigned to the gesture recognizer.
    func addFullWidthBackSwipeGesture(gestureName: String = NavigationGestureKit.defaultFullWidthBackGestureName) {
        let handler = WebViewFullWidthBackSwipeHandler()
        handler.configure(for: self, gestureName: gestureName)
        withUnsafePointer(to: fullWidthHandlerKey) { keyPtr in
            objc_setAssociatedObject(self, keyPtr, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Removes a previously added full-width back swipe gesture recognizer.
    /// - Parameter name: The gesture recognizer name to remove.
    func removeFullWidthBackSwipeGesture(named name: String = NavigationGestureKit.defaultFullWidthBackGestureName) {
        guard let recognizers = gestureRecognizers else { return }
        for recognizer in recognizers where recognizer.name == name {
            removeGestureRecognizer(recognizer)
        }
    }
}
