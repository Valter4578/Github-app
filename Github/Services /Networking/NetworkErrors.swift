//
//  NetworkErrors.swift
//  Github
//
//  Created by Максим Алексеев on 02.01.2021.
//

import Foundation

enum NetworkErrors: Error {
    case unrecognizedError
    case incorrectStatusCode
    case cantDecode 
}
