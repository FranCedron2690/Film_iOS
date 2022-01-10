//
//  CrashalyticsManager.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 4/1/22.
//

import Foundation
import FirebaseCrashlytics

class CrashalyticsManager {
    // Singleton
    private init() {}
    static let shared = CrashalyticsManager()

    private enum CodesNumbersError: Int {
        case errorExecutingURL = 1
        case errorDecodingJson = 2
    }

    func prepareFromRequest(urlExecuted: String, codeStatus: Int, errorMessage: String) {
        let userInfo = [
          "URL": urlExecuted,
          "Status Code": String(codeStatus),
          "Message_info_error": errorMessage
        ]

        let error = NSError.init(domain: "Error executing URL",
                                 code: CodesNumbersError.errorExecutingURL.rawValue,
                                 userInfo: userInfo)

        Crashlytics.crashlytics().record(error: error)
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

        Crashlytics.crashlytics().record(error: error)
    }
}
