#if canImport(SwiftUI) && canImport(UIKit)
import SwiftUI
import UIKit

private struct BackSwipeHandlerView: UIViewControllerRepresentable {
    var isEnabled: Bool

    func makeUIViewController(context: Context) -> InstallerViewController {
        let vc = InstallerViewController()
        vc.update(isEnabled: isEnabled)
        return vc
    }

    func updateUIViewController(_ uiViewController: InstallerViewController, context: Context) {
        uiViewController.update(isEnabled: isEnabled)
    }

    final class InstallerViewController: UIViewController {
        private let handler = NavigationBackSwipeHandler()

        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            guard let parent, UIDevice.current.userInterfaceIdiom == .phone else { return }
            if !handler.isConfigured {
                handler.configure(for: parent)
            }
        }

        func update(isEnabled: Bool) {
            handler.isEnabled = isEnabled
        }
    }
}

public extension View {
    /// Installs a ``NavigationBackSwipeHandler`` for the current view's hosting controller.
    /// - Parameter isEnabled: Whether the handler should be active. Defaults to `true`.
    func navigationBackSwipeHandler(isEnabled: Bool = true) -> some View {
        background(BackSwipeHandlerView(isEnabled: isEnabled).frame(width: 0, height: 0))
    }
}
#endif

