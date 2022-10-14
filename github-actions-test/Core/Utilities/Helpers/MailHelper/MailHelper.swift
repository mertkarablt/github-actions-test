//
//  MailHelper.swift
//  Mess
//
//  Created by Mert Karabulut on 01.05.2021.
//  Copyright © 2020 Loodos. All rights reserved.
//

import Foundation
import MessageUI
import UIKit

public struct MailContent {
    let recipients: [String]
    let subject: String?
    let body: String?

    public init(recipients: [String], subject: String? = "", body: String? = "") {
        self.recipients = recipients
        self.subject = subject
        self.body = body
    }
}

public enum MailApp: String {
    case mail = "Mail"
    case gmail = "Gmail"
    case outlook = "Outlook"
    case yahoo = "Yahoo"
    case spark = "Spark"
}

public class MailHelper: NSObject {
    var content: MailContent

    var mailURL: URL?
    var gmailURL: URL?
    var outlookURL: URL?
    var yahooURL: URL?
    var sparkURL: URL?

    var mailAppInstalled = false
    var gmailAppInstalled = false
    var outlookAppInstalled = false
    var yahooAppInstalled = false
    var sparkAppInstalled = false

    public init(content: MailContent) {
        self.content = content

        let subjectEncoded = content.subject?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let bodyEncoded = content.body?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let receipents = (content.recipients.map { $0 }).joined(separator: ",")

        mailURL = URL(string: "mailto:\(receipents)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        gmailURL = URL(string: "googlegmail://co?to=\(receipents)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        outlookURL = URL(string: "ms-outlook://compose?to=\(receipents)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        yahooURL = URL(string: "ymail://mail/compose?to=\(receipents)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        sparkURL = URL(string: "readdle-spark://compose?recipient=\(receipents)&subject=\(subjectEncoded)&body=\(bodyEncoded)")

        super.init()
    }

    public func action() {
        var actions: [UIAlertAction] = []

        if MFMailComposeViewController.canSendMail() {
            mailAppInstalled = MFMailComposeViewController.canSendMail()
            if let url = mailURL, mailAppInstalled {
                actions.append(UIAlertAction(title: MailApp.mail.rawValue,
                                             style: .default,
                                             handler: { _ in
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }))
            }
        }

        if let url = URL(string: "googlegmail://") {
            gmailAppInstalled = UIApplication.shared.canOpenURL(url)
            if let url = gmailURL, gmailAppInstalled {
                actions.append(UIAlertAction(title: MailApp.gmail.rawValue,
                                             style: .default,
                                             handler: { _ in
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }))
            }
        }

        if let url = URL(string: "ms-outlook://") {
            outlookAppInstalled = UIApplication.shared.canOpenURL(url)
            if let url = outlookURL, outlookAppInstalled {
                actions.append(UIAlertAction(title: MailApp.outlook.rawValue,
                                             style: .default,
                                             handler: { _ in
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }))
            }
        }

        if let url = URL(string: "ymail://") {
            yahooAppInstalled = UIApplication.shared.canOpenURL(url)
            if let url = yahooURL, yahooAppInstalled {
                actions.append(UIAlertAction(title: MailApp.yahoo.rawValue,
                                             style: .default,
                                             handler: { _ in
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }))
            }
        }

        if let url = URL(string: "readdle-spark://") {
            sparkAppInstalled = UIApplication.shared.canOpenURL(url)
            if let url = sparkURL, sparkAppInstalled {
                actions.append(UIAlertAction(title: MailApp.spark.rawValue,
                                             style: .default,
                                             handler: { _ in
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }))
            }
        }

        if actions.count == 1 {
            // Open installed app
            if let url = mailURL, mailAppInstalled {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            if let url = gmailURL, gmailAppInstalled {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            if let url = outlookURL, outlookAppInstalled {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            if let url = yahooURL, yahooAppInstalled {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            if let url = sparkURL, sparkAppInstalled {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if actions.count >= 2 {
            // Show options
            UIAlertController.showAlert(title: "", message: "", actions: actions)
        }
    }
}
