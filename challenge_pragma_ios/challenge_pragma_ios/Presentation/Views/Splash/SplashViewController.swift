//
//  SplashViewController.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//

import UIKit

final class SplashViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Catbreeds"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cat_logo")) 
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSplashSequence()
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),

            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func startSplashSequence() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.transitionToHome()
        }
    }

    private func transitionToHome() {
        let homeVC = HomeViewController()
        let navVC = UINavigationController(rootViewController: homeVC)
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = navVC
            window.makeKeyAndVisible()
        }
    }
}
