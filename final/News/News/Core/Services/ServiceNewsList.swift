//
//  ServiceNewsList.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation
import RxSwift

protocol ServiceNewsList: Service {
  func retrieveNews() -> Observable<Result<ModelNewsListResponse, APIError>>
}

extension ServiceNewsList {
  func retrieveNews() -> Observable<Result<ModelNewsListResponse, APIError>> {
    let url = kURL
    let request = URLRequest.build(url: url,
                                   method: .get,
                                   dataBody: nil,
                                   headers: nil)

    return apiSession.request(with: request)
  }
}
