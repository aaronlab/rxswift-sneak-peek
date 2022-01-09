//
//  LoadingView.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import SnapKit
import Then
import UIKit

class LoadingView: UIView {
  // MARK: - Private Properties

  private var indicator = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                y: 0, width: 50,
                                                                height: 50))

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
    layoutView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureView()
    layoutView()
  }
}

// MARK: - Configure

extension LoadingView {
  private func configureView() {
    backgroundColor = .black.withAlphaComponent(0.6)
    addSubview(indicator)
  }
}

// MARK: - Layout

extension LoadingView {
  private func layoutView() {
    indicator.center = center
    indicator.startAnimating()
  }
}
