//
//  SentryManager.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 4/1/22.
//

import Foundation
import Sentry

class SentryManager {

    // Singleton
    private init() {}
    static let shared = SentryManager()

    private enum CodesNumbersError: Int {
        case errorExecutingURL = 1
        case errorDecodingJson = 2
    }

    func prepareFromRequest(urlExecuted: String, codeStatus: Int, errorMessage: String) {
        let userInfo = [
          "URL": urlExecuted,
          "Status Code": String(codeStatus),
          "Message info error": errorMessage
        ]

        let error = NSError.init(domain: "Error executing URL",
                                 code: CodesNumbersError.errorExecutingURL.rawValue,
                                 userInfo: userInfo)

        SentrySDK.capture(error: error)
    }

    func prepareFromJsonDecoding(urlExecuted: String, modelName: String, errorMessage: String) {
        let userInfo = [
            "URL": urlExecuted,
          "Name Model Decoding": modelName,
          "Message info error": errorMessage
        ]

        let error = NSError.init(domain: "Error decoding data",
                                 code: CodesNumbersError.errorDecodingJson.rawValue,
                                 userInfo: userInfo)

        SentrySDK.configureScope { scope in
            scope.setTag(value: "prueba", key: "NetworkError")
        }

        SentrySDK.capture(error: error)
    }
}
