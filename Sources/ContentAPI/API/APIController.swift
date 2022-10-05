import Vapor

// TODO: - Add Lifecycle Methods
// - before / after list
// - before / after get
// - before / after create
// - before / after update
// - before / after patch
// - before / after delete

public protocol APIController:
    ListContentController,
    GetContentController,
    CreateContentController,
    UpdateContentController,
    PatchContentController,
    DeleteContentController {
    func setupRoutes(routes: RoutesBuilder, privateRoutes: RoutesBuilder?, on pathComponent: PathComponent)
}

public extension APIController {
    func setupRoutes(routes: RoutesBuilder, privateRoutes: RoutesBuilder? = nil, on pathComponent: PathComponent) {
        let base = routes.grouped(pathComponent)
        setupListRoute(routes: base)
        setupGetRoute(routes: base)
        if let privateRoutes {
            let privateBase = privateRoutes.grouped(pathComponent)
            setupCreateRoute(routes: privateBase)
            setupUpdateRoute(routes: privateBase)
            setupPatchRoute(routes: privateBase)
            setupDeleteRoute(routes: privateBase)
        } else {
            setupCreateRoute(routes: base)
            setupUpdateRoute(routes: base)
            setupPatchRoute(routes: base)
            setupDeleteRoute(routes: base)
        }
    }
}
