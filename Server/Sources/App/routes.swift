import Vapor

public func routes(_ router: Router) throws {

    router.get { req in
        return "Use /animation/<id> to request specific animation."
    }

    let animationsController = AnimationsController()
    router.get("animation", String.parameter, use: animationsController.animation)
}
