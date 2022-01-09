//
//  DataSourceArticle.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation
import RxDataSources

struct DataSourceArticle {
  var section: Int
  var items: [Item]
}

extension DataSourceArticle: SectionModelType {
  typealias Item = ModelArticle

  init(original: DataSourceArticle, items: [ModelArticle]) {
    self = original
    self.items = items
  }
}
