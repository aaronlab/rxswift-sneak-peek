//
//  DataSourceArticle.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation
import RxDataSources

struct DataSourceArticle {
  typealias Item = ModelArticle

  var section: Int
  var items: [Item]

  // TODO: 03. Implement SectionModelType
}
