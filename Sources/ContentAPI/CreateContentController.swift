import Fluent
import Vapor

public protocol CreateContentController: ContentController where Model: CreateContentRepresentable {
    func beforeCreate(req: Request, model: Model, content: Model.CreateContent) async throws
    func create(_ req: Request) async throws -> Model.GetContent
    func setupCreateRoute(routes: RoutesBuilder)
}

public extension CreateContentController {
    func beforeCreate(req _: Request, model _: Model, content _: Model.CreateContent) async throws {}
    func create(_ req: Request) async throws -> Model.GetContent {
        try Model.CreateContent.validate(content: req)
        let input = try req.content.decode(Model.CreateContent.self)
        let model = Model()
        try await beforeCreate(req: req, model: model, content: input)
        try model.create(input)
        try await model.create(on: req.db)
        return model.getContent
    }

    func setupCreateRoute(routes: RoutesBuilder) {
        routes.post(use: create(_:))
    }
}
