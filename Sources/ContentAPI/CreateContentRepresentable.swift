import Vapor

public protocol CreateContentRepresentable: GetContentRepresentable {
    associatedtype CreateContent: ValidatableContent

    func create(_: CreateContent) throws
}

public extension CreateContentRepresentable {
    func create(_: CreateContent) throws {}
}
