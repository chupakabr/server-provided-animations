//
//  AnimationsProviderProtocol.swift
//  ServerProvidedAnimation
//
//  Created by Valeriy Chevtaev on 25/11/2018.
//  Copyright © 2018 Valerii Chevtaev. All rights reserved.
//

import Foundation
import Lottie

protocol AnimationsProviderProtocol {
    typealias Completion = (_ animation: LOTComposition?) -> Void

    func loadAnimation(byId id: String, completion: @escaping Completion)
}
