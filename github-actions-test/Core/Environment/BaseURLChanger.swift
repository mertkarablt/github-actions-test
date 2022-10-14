//
//  BaseURLChanger.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import UIKit

public class BaseURLChanger {
    public static let shared = BaseURLChanger()
    public var config: EnvironmentsConfig?
    var userDefaults = UserDefaults.standard

    private init() {
        // This prevents from using the default '()' initializer for this class.
    }

    public func initialize() {
        setConfig()
        setInitialEnvironmentValues()
    }

    public func presentURLChanger() {
        guard let config = self.config else { return }
        let controller = BaseURLsViewController(config: config)
        let navigationController = UINavigationController(rootViewController: controller)
        UIApplication.topViewController()?.present(
            navigationController,
            animated: true,
            completion: nil)
    }

    private func setConfig() {
        guard let configURL = Bundle.main.path(
                forResource: "Environments",
                ofType: "plist"
        ) else {
            return
        }
        let url = URL(fileURLWithPath: configURL)
        guard let data = try? Data(contentsOf: url, options: .alwaysMapped) else {
            return
        }
        let decoder = PropertyListDecoder()
        guard let config = try? decoder.decode(
                EnvironmentsConfig.self,
                from: data
        ) else {
            fatalError("Control EnvironmetsConfig struct!!!")
        }
        self.config = config
    }

    private func setInitialEnvironmentValues() {
        guard let config = config else { return }
        if userDefaults.serviceEnvValue.isEmpty {
            userDefaults.serviceEnvValue = config.environment(
                for: .serviceEnv,
                environmentType: .prod)?.value ?? ""
        }
        if userDefaults.masterpassEnvValue.isEmpty {
            userDefaults.masterpassEnvValue = config.environment(
                for: .masterpassEnv,
                environmentType: .prod
            )?.value ?? ""
        }
        if userDefaults.personaClickEnvValue.isEmpty {
            userDefaults.personaClickEnvValue = config.environment(
                for: .personaClickEnv,
                environmentType: .prod
            )?.value ?? ""
        }
    }
}
