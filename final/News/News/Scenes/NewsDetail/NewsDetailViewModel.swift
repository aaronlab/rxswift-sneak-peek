//
//  NewsDetailViewModel.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Foundation
import RxCocoa
import RxSwift

protocol NewsDetailViewModelOutput {
  var _article: BehaviorRelay<ModelArticle?> { get }
}

extension NewsDetailViewModelOutput {
  var title: Observable<String?> {
    _article.map(\.?.title)
  }

  var imageURL: Observable<URL?> {
    _article.map(\.?.imageURL)
  }

  var timeStamp: Observable<String?> {
    _article.map(\.?.timeStamp)
  }

  var content: Observable<String?> {
    _article.map(\.?.longContent)
  }

  var url: Observable<URL?> {
    _article.map(\.?.articleURL)
  }
}

final class NewsDetailViewModel: Output {
  var apiSession: APIService = APISession()
  var bag = DisposeBag()
  var output = Output()

  // MARK: - Output

  struct Output: NewsDetailViewModelOutput {
    var _article: BehaviorRelay<ModelArticle?> = .init(value: nil)
  }

  // MARK: - Init

  deinit {
    bag = DisposeBag()
  }
}

// MARK: - Output

extension NewsDetailViewModel {
  func bindOutput() {}
}
