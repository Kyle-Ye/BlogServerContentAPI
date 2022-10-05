//
//  GetContentRepresentable.swift
//  
//
//  Created by Kyle on 2022/10/3.
//

import Vapor

public protocol GetContentRepresentable {
    associatedtype GetContent: Content
    
    var getContent: GetContent { get }
}
