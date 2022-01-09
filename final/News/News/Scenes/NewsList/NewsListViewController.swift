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
    viewModel.fetchAll()
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
    tableView.rx.itemSelected
      .bind(onNext: { [weak self] indexPath in
        guard let self = self else { return }
        self.tableView.deselectRow(at: indexPath, animated: true)
      })
      .disposed(by: bag)
  }

  private func bindTableViewModelSelected() {
    tableView.rx.modelSelected(ModelArticle.self)
      .asDriver()
      .drive(onNext: { [weak self] article in
        guard let self = self else { return }
        let vc = NewsDetailViewController()
        vc.viewModel.output._article.accept(article)
        self.navigationController?.pushViewController(vc, animated: true)
      })
      .disposed(by: bag)
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
    viewModel.output.loading
      .asDriver()
      .drive(onNext: { [weak self] loading in
        guard let self = self else { return }
        self.loading(loading: loading)
      })
      .disposed(by: bag)
  }

  private func bindOnError() {
    viewModel.output.onError
      .asDriver(onErrorJustReturn: nil)
      .drive(onNext: { [weak self] error in
        guard let self = self,
              let error = error else {
          return
        }
        self.showErrorAlert(error.description)
      })
      .disposed(by: bag)
  }

  private func bindDataSource() {
    let dataSource = dataSource()

    viewModel.output.dataSource
      .asDriver(onErrorJustReturn: [])
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
  }
}

// MARK: - DataSource

extension NewsListViewController {
  private func dataSource() -> RxTableViewSectionedReloadDataSource<DataSourceArticle> {
    let dataSource =
      RxTableViewSectionedReloadDataSource<DataSourceArticle> { _, tableView, indexPath, article in

        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: cellIdentifier,
          for: indexPath
        ) as? NewsArticleCell else {
          return UITableViewCell()
        }

        cell.configureCell(with: article, with: cellSize)

        return cell
      }

    return dataSource
  }
}
