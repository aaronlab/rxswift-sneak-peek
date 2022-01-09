//
//  NewsListViewController.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import RxCocoa
import RxDataSources
import RxGesture
import RxSwift
import SnapKit
import Then
import UIKit

private let cellIdentifier = "newsListTableViewCellIdentifier"
private let cellSize = CGSize(width: 120, height: 120)

class NewsListViewController: ViewController {
  private var bag = DisposeBag()
  private var viewModel = NewsListViewModel()

  private var tableView = UITableView()
    .then {
      $0.rowHeight = cellSize.height
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    layoutView()
    bindRx()

    // TODO: 14. Fetch All
  }
}

// MARK: - Configure

extension NewsListViewController {
  private func configureView() {
    configureNavigationBar()
    configureTableView()
  }

  private func configureNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "News"
  }

  private func configureTableView() {
    view.addSubview(tableView)
    tableView.register(NewsArticleCell.self,
                       forCellReuseIdentifier: cellIdentifier)
  }
}

// MARK: - Layout

extension NewsListViewController {
  private func layoutView() {
    layoutTableView()
  }

  private func layoutTableView() {
    tableView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

// MARK: - Bind

extension NewsListViewController {
  private func bindRx() {
    bindInput()
    bindOutput()
  }
}

// MARK: - Input

extension NewsListViewController {
  func bindInput() {
    bindTableViewItemSelected()
    bindTableViewModelSelected()
  }

  private func bindTableViewItemSelected() {
    // TODO: 21. Bind ItemSelected -> Deselect Item
  }

  private func bindTableViewModelSelected() {
    // TODO: 22. Bind ModelSelected -> Move Detail View
  }
}

// MARK: - Output

extension NewsListViewController {
  func bindOutput() {
    bindLoading()
    bindOnError()
    bindDataSource()
  }

  private func bindLoading() {
    // TODO: 10. Bind Loading & Show Loading View
  }

  private func bindOnError() {
    // TODO: 11. Bind Error & Show Alert
  }

  private func bindDataSource() {
    // TODO: 12. Bind DataSource
  }
}

// MARK: - DataSource

extension NewsListViewController {
  private func dataSource() {
    // TODO: 13. Create DataSource and then return
  }
}
