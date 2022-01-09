//
//  APIService.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation
import RxSwift

protocol APIService {
  func request<T: Decodable>(with request: URLRequest) -> Observable<Result<T, APIError>>
}
