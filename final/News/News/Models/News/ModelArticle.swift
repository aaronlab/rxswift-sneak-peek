//
//  ModelArticle.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

struct ModelArticle: Decodable {
  var author: String?
  var title: String?
  var description: String?
  var url: String?
  var urlToImage: String?
  var publishedAt: String?
  var content: String?
}

extension ModelArticle {
  var imageURL: URL? {
    guard let urlToImage = urlToImage else { return nil }
    return URL(string: urlToImage)
  }

  var timeStamp: String? {
    guard let publishedAt = publishedAt,
          let first = publishedAt.split(separator: "T").first else {
      return nil
    }

    return String(first)
  }

  var articleURL: URL? {
    guard let url = url else { return nil }
    return URL(string: url)
  }

  var longContent: String {
    guard var content = content else { return "" }

    content = String(repeating: content, count: 30)

    return content
  }
}
