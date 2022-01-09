//
//  RetrieveNewsListOperation.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation

class RetrieveNewsListOperation<T: BindableViewModel & ServiceNewsList>: NetworkOperation {
  private let viewModel: T

  var articles: [ModelArticle] = []

  init(viewModel: T) {
    self.viewModel = viewModel

    super.init()
  }

  override func main() {
    guard !isCancelled else { return }

    // TODO: 09. Implement Request Operation
    requestDidFinish(nil, success: true)
  }
}

extension RetrieveNewsListOperation: ArticlesProvider {}
