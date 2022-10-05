import Vapor

public protocol PatchContentRepresentable: GetContentRepresentable {
    associatedtype PatchContent: ValidatableContent

    func patch(_: PatchContent) throws
}

public extension PatchContentRepresentable {
    func patch(_: PatchContent) throws {}
}
