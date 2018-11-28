import Vapor

final class AnimationsStorage: Service {

    func animation(byId id: String) -> AnimationModel? {
        if let jsonData = self.loadContent(of: id) {
            return AnimationModel(id: id, jsonData: jsonData)
        } else {
            return nil
        }
    }

    // MARK: - Helpers

    private let animationNames: [String] = [
        "clouds",
        "fireworks"
    ]

    private func loadContent(of filename: String) -> String? {
        guard self.animationNames.contains(filename) else { return nil }

        let bundle = Bundle(for: AnimationsStorage.self)
        guard let filepath = bundle.path(forResource: filename, ofType: "json") else { return nil }

        do {
            return try String(contentsOfFile: filepath)
        } catch {
            return nil
        }
    }
}
