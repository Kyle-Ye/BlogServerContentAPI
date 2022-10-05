import Vapor

public protocol ValidatableContent: Content, Validatable {}

public extension ValidatableContent {
    static func validations(_: inout Validations) {}
}
