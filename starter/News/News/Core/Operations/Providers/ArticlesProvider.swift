//
//  ArticlesProvider.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

protocol ArticlesProvider {
  var articles: [ModelArticle] { get }
}
