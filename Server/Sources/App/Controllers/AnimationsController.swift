import Vapor

final class AnimationsController {

    func animation(_ req: Request) throws -> AnimationModel {
        let animationId = try req.parameters.next(String.self)
        let animationsStorage = try req.make(AnimationsStorage.self)

        if let animation = animationsStorage.animation(byId: animationId) {
            return animation
        } else {
            throw Abort(.notFound)
        }
    }
}
