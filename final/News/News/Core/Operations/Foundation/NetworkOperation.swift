//
//  NetworkOperation.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

class NetworkOperation: AsyncOperation, APIResponseProvider {
  var apiError: APIError?
  var success: Bool = false
  var onComplete: APIResponseProviderOnComplete?
}
