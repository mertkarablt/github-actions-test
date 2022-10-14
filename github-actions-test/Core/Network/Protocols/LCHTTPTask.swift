//
//  LCHTTPTask.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Alamofire

public enum LCHTTPTask {
    /// A request with no additional data.
    case requestPlain

    /// A requests body set with data.
    case requestData(Data)

    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)

    /// A request body set with `Encodable` type and custom encoder
    case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder)

    /// A requests body set with encoded parameters.
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)

    /// A requests body set with data, combined with url parameters.
    case requestCompositeData(bodyData: Data, urlParameters: [String: Any])

    /// A requests body set with encoded parameters combined with url parameters.
    case requestCompositeParameters(bodyParameters: Parameters, bodyEncoding: ParameterEncoding, urlParameters: Parameters)

    /// A file upload task.
    case uploadFile(URL)

    /// A "multipart/form-data" upload task.
    case uploadMultipart([LCMultipartFormData])

    /// A "multipart/form-data" upload task  combined with url parameters.
    case uploadCompositeMultipart([LCMultipartFormData], urlParameters: Parameters)

    /// A file download task to a destination.
    case downloadDestination(DownloadRequest.Destination)

    /// A file download task to a destination with extra parameters using the given encoding.
    case downloadParameters(parameters: Parameters, encoding: ParameterEncoding, destination: DownloadRequest.Destination)
}
