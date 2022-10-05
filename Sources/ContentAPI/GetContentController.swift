import Fluent
import Vapor

public protocol GetContentController: IdentifiableContentController where Model: GetContentRepresentable{
    func get(_ req: Request) async throws -> Model.GetContent
    func setupGetRoute(routes: RoutesBuilder)
}

public extension GetContentController {
    func get(_ req: Request) async throws -> Model.GetContent {
        try await find(req).getContent
    }

    func setupGetRoute(routes: RoutesBuilder) {
        routes.get(idPathComponent, use: get)
    }
}
