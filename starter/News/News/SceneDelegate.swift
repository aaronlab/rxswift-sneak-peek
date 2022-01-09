//
//  SceneDelegate.swift
//  News
//
//  Created by Aaron Lee on 2022/01/09.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo _: UISceneSession,
    options _: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let newsVC = NewsListViewController()
    let navC = UINavigationController(rootViewController: newsVC)

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navC
    window?.makeKeyAndVisible()
  }
}
