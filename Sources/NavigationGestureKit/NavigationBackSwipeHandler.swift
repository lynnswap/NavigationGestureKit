//
//  NavigationBackSwipeHandler.swift
//  NavigationGestureKit
//
//  Created by lynnswap on 2025/05/30.
//
import UIKit

@MainActor
public final class NavigationBackSwipeHandler: NSObject {
    public var isConfigured: Bool { navigationController != nil }
    public var isEnabled: Bool = true {
        didSet { panGesture.isEnabled = isEnabled }
    }
    public func configure(for vc: UIViewController) {
        guard let nav = vc.findNavigationController() else { return }
        navigationController = nav
        guard let systemPop = nav.interactivePopGestureRecognizer,
              let targets = systemPop.value(forKey: "targets")
        else { return }

        panGesture.setValue(targets, forKey: "targets")
        panGesture.delegate = self
        nav.view.addGestureRecognizer(panGesture)
    }
    private weak var navigationController: UINavigationController?
    private let panGesture = UIPanGestureRecognizer()
}

extension NavigationBackSwipeHandler: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gesture: UIGestureRecognizer) -> Bool {
        guard let nav = navigationController,
              nav.viewControllers.count > 1,
              let pan = gesture as? UIPanGestureRecognizer
        else { return false }

        let velocity = pan.velocity(in: pan.view)
        return velocity.x > 0 && abs(velocity.x) > abs(velocity.y)
    }
}
extension UIViewController {
    public func findNavigationController() -> UINavigationController? {
        if let nav = self as? UINavigationController { return nav }
        return parent?.findNavigationController()
    }
}
