//
//  APIClient.swift
//  GnaviApp
//
//  Created by 入江真礼 on 2020/04/12.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit
import Alamofire

enum Result<T> {
    case success(T)
    case failure(Error)
    case unauthorizedError
    case forbiddenError
}

enum StatusCode: Int {
    case success = 200
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
}

enum FetchError: Error {
    case missingData   // データがないとき
}

class APIClient {

    /// タイムインターバル
    static let defaultTimeInterval: TimeInterval = 30

    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {

        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening(onUpdatePerforming: { _ in
            })
            return reachabilityManager.isReachable
        }
        return false
    }

    /// GET
    static func requestWithParameters<T: WebAPIRequestProtocol>(request: T,
                                                                completionHandler: @escaping (Result<Data?>) -> Void = { _ in }) {
        guard let url =  URL(string: request.baseURLString + request.path) else {
            fatalError("URLが不正")
        }
        AF.request(url,method: request.httpMethod,
                   parameters: request.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: HTTPHeaders(request.header)).responseJSON { response in

                    printRequest(request, response: response)
                    receivedResponse(response, completionHandler: completionHandler)
        }
    }

    /// POST, PUT, DELETE
    static func request<T: WebAPIRequestProtocol>(request: T,
                                                  completionHandler: @escaping (Result<Data?>) -> Void = { _ in }) {

        guard let url =  URL(string: request.baseURLString + request.path) else {
            fatalError("URLが不正")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.timeoutInterval = defaultTimeInterval
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: request.bodys, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8) ?? "no body data"
            urlRequest.httpBody = jsonString.data(using: .utf8)
        } catch {
            log?.error(error.localizedDescription)
        }

        AF.request(urlRequest).responseJSON { response in
            printRequest(request, response: response)
            receivedResponse(response, completionHandler: completionHandler)
        }
    }
}

/// Multipart
//    static func uploadByMultipart<T: WebAPIRequestProtocol>(request: T,
//                                                            completionHandler: @escaping (Result<Data?>) -> Void = { _ in }) {
//
//        guard let url =  URL(string: request.baseURLString + request.path) else {
//            fatalError("URLが不正")
//        }
//
//        AF.upload( multipartFormData: { multipartFormData in
//            for (key, value) in request.key {
//                if value is String {
//                    if let data = (value as! String).data(using: String.Encoding.utf8) {
//                        multipartFormData.append(data, withName: key)
//                    }
//                } else if value is Data {
//                    let data = (value as! Data)
//                    multipartFormData.append(data, withName: key)
//                } else if let value = value as? [Data] {
//                    for image in value {
//                        multipartFormData.append(image, withName: key + "[]")
//                    }
//                }
//            }
//        }, to: url, headers: HTTPHeaders(request.key)).responseJSON  { response in
//            printRequest(request, response: response)
//            receivedResponse(response, completionHandler: completionHandler)
//        }
//    }
//
//    /// ImportJsonFile
//    static func importJsonFile(filePath: String) -> Data? {
//        let url = URL(fileURLWithPath: filePath)
//        guard let data = try? Data(contentsOf: url) else {
//            return nil
//        }
//        return data
//    }

extension APIClient {

    private static func printRequest<T: WebAPIRequestProtocol>(_ request: T, response: Alamofire.AFDataResponse<Any>) {
        if let body = response.request?.httpBody, let bodyJson = String(data: body, encoding: .utf8) {
            log?.info("\n👆👆👆\nRequestURL:\(request.baseURLString + request.path)" +
                "\nRequestHeader: \(request.header.prettyPrintedJsonString))" +
                "\nReqeustBody : \(bodyJson)" +
                "\nRequestParameter: \(request.parameters.prettyPrintedJsonString)")
        } else {
            log?.info("\n👆👆👆\nRequestURL:\(request.baseURLString + request.path)" +
                "\nRequestHeader: \(request.header.prettyPrintedJsonString))" +
                "\nRequestParameter: \(request.parameters.prettyPrintedJsonString)")
        }
    }

    private static func receivedResponse(_ response: Alamofire.AFDataResponse<Any>,
                                         completionHandler: @escaping (Result<Data?>) -> Void = { _ in }) {

        guard let statusCode = response.response?.statusCode else {
            if let error = response.error {
                completionHandler(Result.failure(error))
            }
            return
        }

        if case .unauthorized? = StatusCode(rawValue: statusCode) {
            log?.error("\n🔻🔻🔻" +
                "\nStatusCode: \(statusCode)")
            completionHandler(Result.unauthorizedError)
            return
        }

        if case .forbidden? = StatusCode(rawValue: statusCode) {
            completionHandler(Result.forbiddenError)
            return
        }

        var responseJson = ""
        if let json = response.value as? [String: Any] {
            responseJson = json.prettyPrintedJsonString
        } else {

            if let jsonArray = response.value as? [[String: Any]] {

                for json in jsonArray {
                    responseJson += json.prettyPrintedJsonString
                }
            }
        }
        switch response.result {

        case .success:
            log?.info("\n👇👇👇" +
                "\nStatusCode: \(statusCode)\nResponseBody: \(responseJson)")
            completionHandler(Result.success(response.data))
            return

        case .failure:
            log?.error("\n🔻🔻🔻" +
                "\nStatusCode: \(statusCode)\nResponseBody: \(responseJson)")

            if let error = response.error {
                completionHandler(Result.failure(error))
                return
            }
        }
    }
}
