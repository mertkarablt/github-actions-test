//
//  LCMultipartFormData.swift
//  LCore
//
//  Created by Mert Karabulut on 10.05.2021.
//

import Foundation
import Alamofire

public struct LCMultipartFormData {
    /// Method to provide the form data.
    public enum FormDataProvider {
        case data(Foundation.Data)
        case file(URL)
        case stream(InputStream, UInt64)
    }

    public init(
        provider: FormDataProvider,
        name: String,
        fileName: String? = nil,
        mimeType: String? = nil
    ) {
        self.provider = provider
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }

    /// The method being used for providing form data.
    public let provider: FormDataProvider

    /// The name.
    public let name: String

    /// The file name.
    public let fileName: String?

    /// The MIME type
    public let mimeType: String?
}

// MARK: RequestMultipartFormData appending
internal extension MultipartFormData {
    func append(data: Data, bodyPart: LCMultipartFormData) {
        if let mimeType = bodyPart.mimeType {
            if let fileName = bodyPart.fileName {
                append(data, withName: bodyPart.name, fileName: fileName, mimeType: mimeType)
            } else {
                append(data, withName: bodyPart.name, mimeType: mimeType)
            }
        } else {
            append(data, withName: bodyPart.name)
        }
    }

    func append(fileURL url: URL, bodyPart: LCMultipartFormData) {
        if let fileName = bodyPart.fileName, let mimeType = bodyPart.mimeType {
            append(url, withName: bodyPart.name, fileName: fileName, mimeType: mimeType)
        } else {
            append(url, withName: bodyPart.name)
        }
    }

    func append(stream: InputStream, length: UInt64, bodyPart: LCMultipartFormData) {
        append(stream, withLength: length, name: bodyPart.name, fileName: bodyPart.fileName ?? "", mimeType: bodyPart.mimeType ?? "")
    }

    func applyMultipartFormData(_ multipartBody: [LCMultipartFormData]) {
        for bodyPart in multipartBody {
            switch bodyPart.provider {
            case .data(let data):
                append(data: data, bodyPart: bodyPart)
            case .file(let url):
                append(fileURL: url, bodyPart: bodyPart)
            case .stream(let stream, let length):
                append(stream: stream, length: length, bodyPart: bodyPart)
            }
        }
    }
}
