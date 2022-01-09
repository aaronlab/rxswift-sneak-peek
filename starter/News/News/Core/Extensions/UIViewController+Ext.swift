//
//  UIViewController+Ext.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import SafariServices
import UIKit

extension UIViewController {
  func showErrorAlert(_ message: String?) {
    let alertController = UIAlertController(title: "Error",
                                            message: message,
                                            preferredStyle: .alert)
    let action = UIAlertAction(title: "Confirm",
                               style: .default)

    alertController.addAction(action)

    present(alertController, animated: true)
  }

  func loading(loading: Bool) {
    if loading {
      let loadingView = LoadingView(frame: view.frame)
      view.addSubview(loadingView)
      return
    }

    guard let loadingView = view.subviews.compactMap({ $0 as? LoadingView }).first else { return }
    loadingView.removeFromSuperview()
  }

  func openSafari(with url: URL?) {
    guard let url = url else { return }

    let config = SFSafariViewController.Configuration()
    config.entersReaderIfAvailable = true

    let vc = SFSafariViewController(url: url, configuration: config)

    present(vc, animated: true)
  }
}
