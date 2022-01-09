//
//  NewsListViewModel.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation
import RxCocoa
import RxSwift

protocol NewsListViewModelOutput: Lodable {
  var _articles: BehaviorRelay<[ModelArticle]> { get }
  var onError: PublishSubject<APIError?> { get }
  var dataSource: Observable<[DataSourceArticle]> { get }
}

extension NewsListViewModelOutput {
  var dataSource: Observable<[DataSourceArticle]> {
    _articles
      .map {
        [DataSourceArticle(section: 0, items: $0)]
      }
  }
}

final class NewsListViewModel: BindableViewModel {
  var apiSession: APIService = APISession()

  var bag = DisposeBag()

  var input = Input()
  var output = Output()

  var utilityQueue = OperationQueue(label: "newsListViewModel.utility")

  // MARK: - Input

  struct Input {}

  // MARK: - Output

  struct Output: NewsListViewModelOutput {
    var loading: BehaviorRelay<Bool> = .init(value: false)
    var _articles: BehaviorRelay<[ModelArticle]> = .init(value: [])
    var onError: PublishSubject<APIError?> = .init()
  }

  // MARK: - Init

  init() {
    bindInput()
    bindOutput()
  }

  deinit {
    bag = DisposeBag()
  }
}

// MARK: - Helpers

extension NewsListViewModel {
  func fetchAll() {
    retrieveNews()
  }
}

// MARK: - Input

extension NewsListViewModel {
  func bindInput() {}
}

// MARK: - Output

extension NewsListViewModel {
  func bindOutput() {}
}

extension NewsListViewModel: ServiceNewsList {
  private func retrieveNews() {
    guard !output.isLoading else { return }

    output.beginLoading()

    let op = RetrieveNewsListOperation(viewModel: self)

    op.onComplete = { [weak self] apiError, success in
      guard let self = self,
            success else {
        self?.output.endLoading()
        self?.output.onError.onNext(apiError)
        return
      }

      let articles = op.articles
      self.output._articles.accept(articles)
      self.output.endLoading()
    }

    utilityQueue.addOperation(op)
  }
}
