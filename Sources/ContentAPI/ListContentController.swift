//
//  ListContentController.swift
//
//
//  Created by Kyle on 2022/10/3.
//

import Fluent
import Vapor

public protocol ListContentController: ContentController where Model: ListContentRepresentable {
    func list(_ req: Request) async throws -> Page<Model.ListItem>
    func setupListRoute(routes: RoutesBuilder)
}

public extension ListContentController {
    func list(_ req: Request) async throws -> Page<Model.ListItem> {
        try await Model.query(on: req.db).paginate(for: req).map(\.listContent)
    }
    func setupListRoute(routes: RoutesBuilder) {
        routes.get(use: list)
    }
}
