//
//  NewsArticleCell.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import Kingfisher
import SnapKit
import Then
import UIKit

class NewsArticleCell: UITableViewCell {
  // MARK: - Public Properties

  var thumbnailImageView = UIImageView()
    .then {
      $0.clipsToBounds = true
      $0.contentMode = .scaleAspectFill
      $0.backgroundColor = .white
      $0.kf.indicatorType = .activity
    }

  var titleLabel = UILabel()
    .then {
      $0.font = .boldSystemFont(ofSize: 18)
      $0.textAlignment = .left
      $0.numberOfLines = 2
      $0.setContentHuggingPriority(.required, for: .vertical)
    }

  var timestampLabel = UILabel()
    .then {
      $0.font = .systemFont(ofSize: 16)
      $0.textAlignment = .left
      $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
      $0.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

  // MARK: - Private Properties

  private var containerView = UIView()

  private var stackView = UIStackView()
    .then {
      $0.axis = .vertical
      $0.distribution = .fill
      $0.alignment = .fill
      $0.spacing = 8
    }

  // MARK: - Init

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureView()
    layoutView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureView()
    layoutView()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    thumbnailImageView.kf.cancelDownloadTask()
    thumbnailImageView.image = nil
    titleLabel.text = nil
    timestampLabel.text = nil
  }
}

// MARK: - Helpers

extension NewsArticleCell {
  func configureCell(with article: ModelArticle, with size: CGSize) {
    let processor = DownsamplingImageProcessor(size: size)

    thumbnailImageView.kf.setImage(with: article.imageURL,
                                   placeholder: UIImage(named: "placeholder"),
                                   options: [
                                     .processor(processor),
                                     .scaleFactor(UIScreen.main.scale),
                                     .cacheOriginalImage,
                                   ])

    titleLabel.text = article.title
    timestampLabel.text = article.timeStamp
  }
}

// MARK: - Configure

extension NewsArticleCell {
  private func configureView() {
    configureSubViews()
  }

  private func configureSubViews() {
    contentView.addSubview(containerView)

    containerView.addSubview(thumbnailImageView)

    containerView.addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(timestampLabel)
  }
}

// MARK: - Layout

extension NewsArticleCell {
  private func layoutView() {
    layoutContainerView()
    layoutThumbnailImageView()
    layoutStackView()
  }

  private func layoutContainerView() {
    containerView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(8)
      $0.bottom.trailing.equalToSuperview().offset(-8)
    }
  }

  private func layoutThumbnailImageView() {
    thumbnailImageView.snp.makeConstraints {
      $0.top.bottom.leading.equalToSuperview()
      $0.width.equalTo(thumbnailImageView.snp.height)
    }
  }

  private func layoutStackView() {
    stackView.snp.makeConstraints {
      $0.top.bottom.trailing.equalToSuperview()
      $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
    }
  }
}
