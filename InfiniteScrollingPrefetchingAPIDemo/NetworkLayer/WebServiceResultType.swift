//
//  WebServiceResultType.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

enum WebServiceResultType<T, E> where E: Error {
  case success(T)
  case failure(E)
}
