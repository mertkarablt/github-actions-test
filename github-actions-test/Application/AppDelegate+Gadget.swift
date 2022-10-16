//
//  AppDelegate+Gadget.swift
//  kapida
//
//  Created by Mert Karabulut on 01.05.2021.
//

#if GADGET
import Foundation
import FLEX

extension AppDelegate {
    func initializeGadget(_ initializeGadget: Bool) {
        FLEXManager.shared.isNetworkDebuggingEnabled = initializeGadget
        if initializeGadget {
            addFLEXGestureRecongizer()
            addURLChangerGestureRecongizer()
            addUserDefaultsClearGestureRecognizer()
            addShowIDFAGestureRecognizer()
        }
    }

    private func addFLEXGestureRecongizer() {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        recognizer.direction = .right
        recognizer.numberOfTouchesRequired = 2
        self.window?.addGestureRecognizer(recognizer)
    }

    private func addURLChangerGestureRecongizer() {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        recognizer.direction = .left
        recognizer.numberOfTouchesRequired = 2
        self.window?.addGestureRecognizer(recognizer)
    }

    private func addShowIDFAGestureRecognizer() {
        let recognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(didThreeFingersSwipe)
        )
        recognizer.direction = .left
        recognizer.numberOfTouchesRequired = 3
        self.window?.addGestureRecognizer(recognizer)
    }

    private func addUserDefaultsClearGestureRecognizer() {
        let recognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(didThreeFingersUpSwipe)
        )
        recognizer.direction = .up
        recognizer.numberOfTouchesRequired = 3
        self.window?.addGestureRecognizer(recognizer)
    }

    @objc
    private func didSwipe(_ recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case .right:
            FLEXManager.shared.showExplorer()
        case .left:
            BaseURLChanger.shared.presentURLChanger()
        default:
            break
        }
    }

    @objc
    private func didThreeFingersSwipe() {
    }

    @objc
    private func didThreeFingersUpSwipe() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            let alert = UIAlertController(
                title: "User defaults",
                message: "Userdefaults Cleared",
                preferredStyle: .alert
            )
            let cancelButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancelButton)
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
}

#endif
