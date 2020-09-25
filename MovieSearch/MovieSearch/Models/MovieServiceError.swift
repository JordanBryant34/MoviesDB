//
//  MovieServiceError.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

enum MovieServiceError: LocalizedError {
  case invalidURL
  case thrownError(Error)
  case noData
  case unableToDecode
  case unableToDecodeImage

  var errorDescription: String? {
      switch self {
      case .invalidURL:
          return "Internal error. Please update or contact support."
      case .thrownError(let error):
          return error.localizedDescription
      case .noData:
          return "The server responded with no data."
      case .unableToDecode:
          return "The server responded with bad data."
      case .unableToDecodeImage:
          return "The server responeded with bad data and it couldn't be decoded into an image."
      }
  }
}
