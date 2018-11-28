//
//  ViewController.swift
//  ServerProvidedAnimation
//
//  Created by Valeriy Chevtaev on 25/11/2018.
//  Copyright © 2018 Valerii Chevtaev. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    private struct Constants {
        static let shouldShowAnimationContainerEdges = true
        static let animationsEndpoint = "http://localhost:8080"
    }

    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var hashtagsStackView: UIStackView!
    @IBOutlet weak var hashtagNameLabel: UILabel!

    private weak var animationView: LOTAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewModel()
        self.setupAnimationContainer()
        self.setupHashtags()
    }

    // MARK: - View model

    private var viewModel: ViewModelProtocol!

    private func setupViewModel() {
        self.viewModel = {
            guard let endpoint = URL(string: Constants.animationsEndpoint) else {
                fatalError("Malformed endpoint URL")
            }
            let animationProvider = ServerAnimationProvider(endpoint: endpoint)
            return ViewModel(animationProvider: animationProvider)
        }()
    }

    // MARK: - Actions

    @IBAction func onPlayAnimationAction(_ sender: Any) {
        self.animationView.stop()

        self.animationView.sceneModel = self.viewModel.animationModel
        self.animationView.play()
    }

    // MARK: - Animations

    private func setupAnimationContainer() {
        self.animationContainer.backgroundColor = .clear

        self.animationView = {
            let view = LOTAnimationView(frame: self.animationContainer.bounds)
            self.animationContainer.addSubview(view)

            if Constants.shouldShowAnimationContainerEdges {
                self.animationContainer.layer.borderWidth = 0.5
                self.animationContainer.layer.borderColor = UIColor.white.cgColor
            }

            return view
        }()
    }

    // MARK: - Hashtags

    private func setupHashtags() {
        let addHashtag: (String) -> Void = { (animationId) in
            let hashtagButton = UIButton(type: .system)
            hashtagButton.accessibilityIdentifier = animationId
            hashtagButton.setTitle("#\(animationId)", for: .normal)
            hashtagButton.addTarget(self, action: #selector(self.selectHashtag), for: .touchUpInside)
            self.hashtagsStackView.addArrangedSubview(hashtagButton)
        }

        addHashtag("clouds")
        addHashtag("fireworks")
        addHashtag("nonexisting")

        self.hashtagNameLabel.text = self.viewModel.selectedHashtagText
    }

    @objc private func selectHashtag(sender: UIButton) {
        self.viewModel.selectedHashtag = sender.accessibilityIdentifier
        self.hashtagNameLabel.text = self.viewModel.selectedHashtagText
    }
}

// MARK: - Status bar
extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
