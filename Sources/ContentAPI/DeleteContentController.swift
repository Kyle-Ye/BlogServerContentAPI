import Fluent
import Vapor

public protocol DeleteContentController: IdentifiableContentController where Model: DeleteContentRepresentable{
    func delete(_ req: Request) async throws -> HTTPStatus
    func setupDeleteRoute(routes: RoutesBuilder)
}

public extension PatchContentController {
    func delete(_ req: Request) async throws -> HTTPStatus {
        let model = try await find(req)
        try await model.delete(on: req.db)
        return .ok
    }

    func setupDeleteRoute(routes: RoutesBuilder) {
        routes.delete(idPathComponent, use: delete)
    }
}
