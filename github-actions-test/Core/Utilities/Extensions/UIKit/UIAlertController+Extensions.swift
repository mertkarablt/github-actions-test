// UIAlertControllerExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

#if canImport(AudioToolbox)
import AudioToolbox
#endif

// MARK: - Methods

extension UIAlertController {
    typealias CompletionHandler = (() -> Void)
    class func showAlert(_ from: UIViewController? = UIApplication.topViewController(),
                         title: String? = nil,
                         message: String? = nil,
                         firstButtonTitle: String?,
                         secondButtonTitle: String? = nil,
                         thirdButtonTitle: String? = nil,
                         preferredStyle: UIAlertController.Style = .actionSheet,
                         firstActionCompletion: CompletionHandler? = nil,
                         secondActionCompletion: CompletionHandler? = nil,
                         thirdActionCompletion: CompletionHandler? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        alert.addAction(UIAlertAction(title: firstButtonTitle, style: .default, handler: { _ in
            firstActionCompletion?()
        }))

        if let secondButtonTitle = secondButtonTitle {
            alert.addAction(UIAlertAction(title: secondButtonTitle, style: .default, handler: { _ in
                secondActionCompletion?()
            }))
        }

        if let thirdButtonTitle = thirdButtonTitle {
            alert.addAction(UIAlertAction(title: thirdButtonTitle, style: .default, handler: { _ in
                thirdActionCompletion?()
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        let vc = from ?? UIApplication.topViewController()
        vc?.present(alert, animated: true, completion: {
        })
    }

    class func showAlert(_ from: UIViewController? = UIApplication.topViewController(),
                         title: String? = nil,
                         message: String? = nil,
                         actions: [UIAlertAction]? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        guard let actions = actions else { return }
        for action in actions {
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        let vc = from ?? UIApplication.topViewController()
        vc?.present(alert, animated: true, completion: {
        })
    }

    /// SwifterSwift: Present alert view controller in the current view controller.
    ///
    /// - Parameters:
    ///   - animated: set true to animate presentation of alert controller (default is true).
    ///   - vibrate: set true to vibrate the device while presenting the alert (default is false).
    ///   - completion: an optional completion handler to be called after presenting alert controller (default is nil).
    func show(animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil) {
        #if targetEnvironment(macCatalyst)
        let window = UIApplication.shared.windows.last
        #else
        let window = UIApplication.shared.keyWindow
        #endif
        window?.rootViewController?.present(self, animated: animated, completion: completion)
        if vibrate {
            #if canImport(AudioToolbox)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            #endif
        }
    }

    /// SwifterSwift: Add an action to Alert
    ///
    /// - Parameters:
    ///   - title: action title
    ///   - style: action style (default is UIAlertActionStyle.default)
    ///   - isEnabled: isEnabled status for action (default is true)
    ///   - handler: optional action handler to be called when button is tapped (default is nil)
    /// - Returns: action created by this method
    @discardableResult
    func addAction(
        title: String,
        style: UIAlertAction.Style = .default,
        isEnabled: Bool = true,
        handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }

    /// SwifterSwift: Add a text field to Alert
    ///
    /// - Parameters:
    ///   - text: text field text (default is nil)
    ///   - placeholder: text field placeholder text (default is nil)
    ///   - editingChangedTarget: an optional target for text field's editingChanged
    ///   - editingChangedSelector: an optional selector for text field's editingChanged
    func addTextField(
        text: String? = nil,
        placeholder: String? = nil,
        tag: Int = 0,
        editingChangedTarget: Any?,
        editingChangedSelector: Selector?) {
        addTextField { textField in
            textField.tag = tag
            textField.text = text
            textField.placeholder = placeholder
            if let target = editingChangedTarget, let selector = editingChangedSelector {
                textField.addTarget(target, action: selector, for: .editingChanged)
            }
        }
    }
}

// MARK: - Initializers

extension UIAlertController {
    /// SwifterSwift: Create new alert view controller with default OK action.
    ///
    /// - Parameters:
    ///   - title: alert controller's title.
    ///   - message: alert controller's message (default is nil).
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: alert controller's tint color (default is nil)
    convenience init(
        title: String,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        defaultActionButtonTitle: String? = "OK",
        tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: style)
        if let defaultActionButtonTitle = defaultActionButtonTitle {
            let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
            addAction(defaultAction)
        }
        if let color = tintColor {
            view.tintColor = color
        }
    }

    /// SwifterSwift: Create new error alert view controller from Error with default OK action.
    ///
    /// - Parameters:
    ///   - title: alert controller's title (default is "Error").
    ///   - error: error to set alert controller's message to it's localizedDescription.
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: alert controller's tint color (default is nil)
    convenience init(
        title: String = "Error",
        error: Error,
        defaultActionButtonTitle: String? = "OK",
        preferredStyle: UIAlertController.Style = .alert,
        tintColor: UIColor? = nil) {
        self.init(title: title, message: error.localizedDescription, preferredStyle: preferredStyle)
        if let defaultActionButtonTitle = defaultActionButtonTitle {
            let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
            addAction(defaultAction)
        }
        if let color = tintColor {
            view.tintColor = color
        }
    }
}

#endif
