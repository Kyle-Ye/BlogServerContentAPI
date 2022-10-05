import Fluent
import Vapor

public protocol UpdateContentController: IdentifiableContentController where Model: UpdateContentRepresentable {
    func beforeUpdate(req: Request, model: Model, content: Model.UpdateContent) async throws
    func update(_ req: Request) async throws -> Model.GetContent
    func setupUpdateRoute(routes: RoutesBuilder)
}

public extension UpdateContentController {
    func beforeUpdate(req _: Request, model _: Model, content _: Model.UpdateContent) async throws {}
    func update(_ req: Request) async throws -> Model.GetContent {
        try Model.UpdateContent.validate(content: req)
        let input = try req.content.decode(Model.UpdateContent.self)
        let model = try await find(req)
        try await beforeUpdate(req: req, model: model, content: input)
        try model.update(input)
        try await model.update(on: req.db)
        return model.getContent
    }

    func setupUpdateRoute(routes: RoutesBuilder) {
        routes.put(idPathComponent, use: update)
    }
}
