import Fluent
import Vapor

public protocol PatchContentController: IdentifiableContentController where Model: PatchContentRepresentable {
    func beforePatch(req: Request, model: Model, content: Model.PatchContent) async throws
    func patch(_ req: Request) async throws -> Model.GetContent
    func setupPatchRoute(routes: RoutesBuilder)
}

public extension PatchContentController {
    func beforePatch(req _: Request, model _: Model, content _: Model.PatchContent) async throws {}
    func patch(_ req: Request) async throws -> Model.GetContent {
        try Model.PatchContent.validate(content: req)
        let input = try req.content.decode(Model.PatchContent.self)
        let model = try await find(req)
        try await beforePatch(req: req, model: model, content: input)
        try model.patch(input)
        try await model.update(on: req.db)
        return model.getContent
    }

    func setupPatchRoute(routes: RoutesBuilder) {
        routes.patch(idPathComponent, use: patch)
    }
}
