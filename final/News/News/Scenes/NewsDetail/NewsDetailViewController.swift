//
//  NewsDetailViewController.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Kingfisher
import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import Then
import UIKit

class NewsDetailViewController: ViewController {
  // MARK: - Internal Properties

  var viewModel = NewsDetailViewModel()

  // MARK: - Private Properties

  private var bag = DisposeBag()

  private var scrollView = UIScrollView()

  private var contentView = UIView()

  private var stackView = UIStackView()
    .then {
      $0.axis = .vertical
      $0.distribution = .fill
      $0.alignment = .fill
      $0.spacing = 16
    }

  private var imageView = UIImageView()
    .then {
      $0.contentMode = .scaleAspectFit
    }

  private var timestampLabel = UILabel()
    .then {
      $0.font = .systemFont(ofSize: 16)
      $0.textAlignment = .right
    }

  private var contentLabel = UILabel()
    .then {
      $0.font = .systemFont(ofSize: 18)
      $0.textAlignment = .left
      $0.numberOfLines = 0
    }

  private var openButton = UIButton(type: .system)
    .then {
      $0.backgroundColor = .black
      $0.setTitleColor(.white, for: .normal)
      $0.clipsToBounds = true
      $0.layer.cornerRadius = 8
      $0.setTitle("Read More", for: .normal)
      $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
      $0.backgroundColor = .systemBlue
    }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureView()
    layoutView()
    bindRx()
  }
}

// MARK: - Configure

extension NewsDetailViewController {
  private func configureView() {
    configureSubViews()
  }

  private func configureSubViews() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    contentView.addSubview(stackView)
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(timestampLabel)
    stackView.addArrangedSubview(contentLabel)
    stackView.addArrangedSubview(openButton)
  }
}

// MARK: - Layout

extension NewsDetailViewController {
  private func layoutView() {
    layoutScrollView()
    layoutStackView()
    layoutOpenButton()
  }

  private func layoutScrollView() {
    scrollView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }

    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalToSuperview()
    }
  }

  private func layoutStackView() {
    stackView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(16)
      $0.trailing.bottom.equalToSuperview().offset(-16)
    }
  }

  private func layoutOpenButton() {
    openButton.snp.makeConstraints {
      $0.height.equalTo(48)
    }
  }
}

// MARK: - Bind

extension NewsDetailViewController {
  private func bindRx() {
    bindInput()
    bindOutput()
  }
}

// MARK: - Input

extension NewsDetailViewController {
  private func bindInput() {
    bindOpenButtonPressed()
  }

  private func bindOpenButtonPressed() {
    let observable = openButton.rx.tap
      .withLatestFrom(viewModel.output.url)

    observable
      .asDriver(onErrorJustReturn: nil)
      .drive(onNext: { [weak self] url in
        guard let self = self else { return }
        self.openSafari(with: url)
      })
      .disposed(by: bag)
  }
}

// MARK: - Output

extension NewsDetailViewController {
  private func bindOutput() {
    bindTitle()
    bindImageURL()
    bindTimeStamp()
    bindContent()
  }

  private func bindTitle() {
    viewModel.output.title
      .asDriver(onErrorJustReturn: nil)
      .drive(rx.title)
      .disposed(by: bag)
  }

  private func bindImageURL() {
    viewModel.output.imageURL
      .asDriver(onErrorJustReturn: nil)
      .drive(onNext: { [weak self] url in
        guard let self = self else { return }
        self.applyImage(with: url)
      })
      .disposed(by: bag)
  }

  private func applyImage(with url: URL?) {
    let hideImageView = url == nil
    imageView.isHidden = hideImageView

    if hideImageView { return }

    let processor = DownsamplingImageProcessor(size: CGSize(width: UIScreen.main.bounds.width,
                                                            height: UIScreen.main.bounds.width))

    imageView.kf.setImage(with: url,
                          placeholder: UIImage(named: "placeholder"),
                          options: [
                            .processor(processor),
                            .scaleFactor(UIScreen.main.scale),
                            .cacheOriginalImage,
                          ])
  }

  private func bindTimeStamp() {
    viewModel.output.timeStamp
      .asDriver(onErrorJustReturn: nil)
      .drive(timestampLabel.rx.text)
      .disposed(by: bag)
  }

  private func bindContent() {
    viewModel.output.content
      .asDriver(onErrorJustReturn: nil)
      .drive(contentLabel.rx.text)
      .disposed(by: bag)
  }
}
