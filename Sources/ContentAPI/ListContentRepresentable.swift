//
//  ListContentRepresentable.swift
//  
//
//  Created by Kyle on 2022/10/3.
//

import Vapor

public protocol ListContentRepresentable {
    associatedtype ListItem: Content
    
    var listContent: ListItem { get }
}
