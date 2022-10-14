//
//  String+Data.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import UIKit

extension String {
    func convertBase64StringToImage() -> UIImage? {
        if let imageData = Data(base64Encoded: self, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
            return UIImage(data: imageData)
        }
        return UIImage()
    }
}
