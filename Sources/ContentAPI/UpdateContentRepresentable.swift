import Vapor

public protocol UpdateContentRepresentable: GetContentRepresentable {
    associatedtype UpdateContent: ValidatableContent

    func update(_: UpdateContent) throws
}

public extension UpdateContentRepresentable {
    func update(_: UpdateContent) throws {}
}