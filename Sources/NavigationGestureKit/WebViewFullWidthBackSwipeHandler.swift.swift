//
//  WebViewFullWidthBackSwipeHandler.swift.swift
//  NavigationGestureKit
//
//  Created by lynnswap on 2025/05/30.
//

#if canImport(UIKit)
import UIKit
import WebKit

@MainActor
public final class WebViewFullWidthBackSwipeHandler: NSObject {
    public func configure(for webView: WKWebView) {
        self.webView = webView
        guard let edgePan = webView.gestureRecognizers?.first(where: { $0 is UIScreenEdgePanGestureRecognizer }),
              let targets = edgePan.value(forKey: "targets") as? [NSObject]
        else { return }

        panGesture.setValue(targets, forKey: "targets")
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
#endif
