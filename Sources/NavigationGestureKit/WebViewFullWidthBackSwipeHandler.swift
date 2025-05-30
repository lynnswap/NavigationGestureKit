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
    public func configure(for webView: WKWebView, gestureName: String = NavigationGestureKit.defaultFullWidthBackGestureName) {
        self.webView = webView
        guard let edgePan = webView.gestureRecognizers?.first(where: { $0 is UIScreenEdgePanGestureRecognizer }),
              let targets = edgePan.value(forKey: "targets") as? [NSObject]
        else { return }

        panGesture.setValue(targets, forKey: "targets")
        panGesture.name = gestureName
        panGesture.delegate = self
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
private enum AssociatedKeys {
    static var fullWidthHandler: UInt8 = 0
}

public extension WKWebView {
    /// Installs and returns a ``WebViewFullWidthBackSwipeHandler`` for this web view.
    /// The handler is created only once and stored via Objective-C associated objects.
    var fullWidthBackSwipeHandler: WebViewFullWidthBackSwipeHandler {
        if let handler = objc_getAssociatedObject(self, &AssociatedKeys.fullWidthHandler) as? WebViewFullWidthBackSwipeHandler {
            return handler
        }
        let handler = WebViewFullWidthBackSwipeHandler()
        handler.configure(for: self, gestureName: NavigationGestureKit.defaultFullWidthBackGestureName)
        objc_setAssociatedObject(self, &AssociatedKeys.fullWidthHandler, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return handler
    }

    /// Installs a full-width back swipe gesture recognizer using a handler stored via associated objects.
    /// - Parameter gestureName: The name to assign to the gesture recognizer.
    func addFullWidthBackSwipeGesture(gestureName: String = NavigationGestureKit.defaultFullWidthBackGestureName) {
        fullWidthBackSwipeHandler.configure(for: self, gestureName: gestureName)
    }

    /// Removes the full-width back swipe gesture recognizer with the specified name.
    /// - Parameter gestureName: Name of the gesture recognizer to remove.
    func removeFullWidthBackSwipeGesture(named gestureName: String = NavigationGestureKit.defaultFullWidthBackGestureName) {
        gestureRecognizers?
            .filter { $0.name == gestureName }
            .forEach(removeGestureRecognizer)
    }
}
