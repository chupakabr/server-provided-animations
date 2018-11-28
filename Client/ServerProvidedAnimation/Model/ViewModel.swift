//
//  ViewModel.swift
//  ServerProvidedAnimation
//
//  Created by Valeriy Chevtaev on 25/11/2018.
//  Copyright © 2018 Valerii Chevtaev. All rights reserved.
//

import Foundation
import Lottie

protocol ViewModelProtocol {
    var animationModel: LOTComposition? { get }

    var availableHashtags: [String] { get }
    var selectedHashtag: String? { get set }
    var selectedHashtagText: String { get }
}

final class ViewModel: ViewModelProtocol {
    private let animationProvider: AnimationsProviderProtocol

    init(animationProvider: AnimationsProviderProtocol) {
        self.animationProvider = animationProvider
    }

    // MARK: - ViewModelProtocol

    var animationModel: LOTComposition?

    var availableHashtags: [String] = [
        "clouds",
        "fireworks",
        "nonexisting"
    ]

    var selectedHashtag: String? {
        didSet {
            if selectedHashtag != oldValue, let selectedHashtag = selectedHashtag {
                self.animationProvider.loadAnimation(byId: selectedHashtag) { [weak self] (animationModel) in
                    self?.animationModel = animationModel
                }
            }
        }
    }

    var selectedHashtagText: String {
        if let hashtag = self.selectedHashtag {
            return "#\(hashtag)"
        } else {
            return "hashtag is not selected"
        }
    }
}
