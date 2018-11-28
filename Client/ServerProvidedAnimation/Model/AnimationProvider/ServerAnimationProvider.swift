//
//  ServerAnimationProvider.swift
//  ServerProvidedAnimation
//
//  Created by Valeriy Chevtaev on 25/11/2018.
//  Copyright © 2018 Valerii Chevtaev. All rights reserved.
//

import Foundation
import Lottie

final class ServerAnimationProvider: AnimationsProviderProtocol {
    private let endpoint: URL

    init(endpoint: URL) {
        self.endpoint = endpoint
    }

    func loadAnimation(byId id: String, completion: @escaping Completion) {
        let path = "/animation/\(id)"
        guard let animationUrl = URL(string: path, relativeTo: self.endpoint) else {
            completion(nil)
            return
        }

        URLSession.shared.invalidateAndCancel()

        print("url: \(animationUrl.absoluteString)")
        let task = URLSession.shared.dataTask(with: animationUrl) { (data, response, error) in
            guard error == nil, let data = data, let json = self.parseJson(from: data) else {
                completion(nil)
                return
            }
            let animation = LOTComposition(json: json)
            completion(animation)
        }
        task.resume()
    }

    // MARK: - Helpers

    private func parseJson(from data: Data?) -> [AnyHashable : Any]? {
        guard let data = data else { return nil }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any]
            return json
        } catch {
            return nil
        }
    }
}
