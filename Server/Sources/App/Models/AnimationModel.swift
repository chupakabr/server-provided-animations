import Vapor

final class AnimationModel {
    let id: String
    let jsonData: String

    init(id: String, jsonData: String) {
        self.id = id
        self.jsonData = jsonData
    }
}

// MARK: - JSON convertible
extension AnimationModel: Content {
    static let defaultContentType: MediaType = .json

    func encode(for req: Request) throws -> EventLoopFuture<Response> {
        let res = req.response()
        try res.content.encode(self.jsonData)
        return Future.map(on: req) { res }
    }
}
