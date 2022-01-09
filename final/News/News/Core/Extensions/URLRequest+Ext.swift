//
//  URLRequest+Ext.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Alamofire
import Foundation

extension URLRequest {
  typealias Headers = [String: String?]
  typealias DictionaryBody = [String: Any]

  private mutating func applyMethod(_ method: HTTPMethod = .get) {
    httpMethod = method.rawValue
  }

  private mutating func applyHeaders(_ headers: Headers? = nil) {
    guard let headers = headers else { return }

    headers.forEach { key, value in
      setValue(value, forHTTPHeaderField: key)
    }
  }

  private mutating func applyDictionaryBody(_ body: DictionaryBody? = nil) {
    guard let body = body else { return }

    let data = try? JSONSerialization.data(withJSONObject: body, options: [])
    httpBody = data
  }

  private mutating func applyEncodableBody<T: Encodable>(_ body: T? = nil) {
    guard let body = body else { return }

    httpBody = body.toJson()
  }

  private static func createJsonRequest(url: URL,
                                        method: HTTPMethod = .get,
                                        headers: Headers? = nil) -> URLRequest {
    var request = URLRequest(url: url)
    request.applyMethod(method)
    request.applyHeaders(headers)
    return request
  }

  static func build(url: URL,
                    method: HTTPMethod = .get,
                    dataBody: Data? = nil,
                    headers: Headers? = nil) -> URLRequest {
    var request = URLRequest.createJsonRequest(url: url,
                                               method: method,
                                               headers: headers)
    request.httpBody = dataBody

    return request
  }

  static func build(url: URL,
                    method: HTTPMethod = .get,
                    dictBody: DictionaryBody? = nil,
                    headers: Headers? = nil) -> URLRequest {
    var request = URLRequest.createJsonRequest(url: url,
                                               method: method,
                                               headers: headers)
    request.applyDictionaryBody(dictBody)

    return request
  }

  static func build<T: Encodable>(url: URL,
                                  method: HTTPMethod = .get,
                                  encodableBody: T? = nil,
                                  headers: Headers? = nil) -> URLRequest {
    var request = URLRequest.createJsonRequest(url: url,
                                               method: method,
                                               headers: headers)
    request.applyEncodableBody(encodableBody)

    return request
  }
}
