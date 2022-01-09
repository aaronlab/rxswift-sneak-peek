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
  // TODO: 15. Implement Top Level Output View Model
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
