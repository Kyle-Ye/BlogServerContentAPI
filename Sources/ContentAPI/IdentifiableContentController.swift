import Fluent
import Vapor

public protocol IdentifiableContentController: ContentController {
    var idParamKey: String { get }
    var idPathComponent: PathComponent { get }
    func find(_ req: Request) async throws -> Model
}

public extension IdentifiableContentController {
    var idParamKey: String { "id" }
    var idPathComponent: PathComponent { .init(stringLiteral: ":" + idParamKey) }
}

public extension IdentifiableContentController where Model.IDValue == UUID{
    func find(_ req: Request) async throws -> Model {
        guard let id = req.parameters.get(idParamKey, as: Model.IDValue.self) else {
            throw Abort(.badRequest)
        }
        guard let model = try await Model.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        return model
    }
}
