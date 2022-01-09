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

    viewModel.retrieveNews()
      .subscribe(onNext: { [weak self] result in

        guard let self = self else { return }

        switch result {
        case let .success(response):
          guard let articles = response.articles else {
            self.requestDidFinish(.decode, success: false)
            return
          }

          self.articles = articles
          self.requestDidFinish(nil, success: true)
        case let .failure(error):
          self.requestDidFinish(error, success: false)
        }

      })
      .disposed(by: viewModel.bag)
  }
}

extension RetrieveNewsListOperation: ArticlesProvider {}
