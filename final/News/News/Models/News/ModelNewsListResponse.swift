//
//  ModelNewsListResponse.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

struct ModelNewsListResponse: Decodable {
  var articles: [ModelArticle]?
}
