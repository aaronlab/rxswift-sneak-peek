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
  // TODO: 01. Implement articles
  // TODO: 02. Implement onError
  // TODO: 04. Implement DataSource
}

extension NewsListViewModelOutput {
  // TODO: 05. Implement Top Level Output View Model
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

  struct Output {
    // TODO: 06. Conform NewsListViewModelOutput Protocol
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
    // TODO: 08. Implement Operation or Task
  }
}
