//
// Created by Wei Zhang on 8/19/18.
// Copyright (c) 2018 BGI Group Inc. All rights reserved.
//

import Foundation
import RxSwift

enum OperationServiceError: Error {
  case notSignedIn
}

protocol OperationServiceType {
  typealias Operation = Models.Operation
  typealias User = Models.User

  func operations() -> Observable<[Operation]>

  func user() -> Observable<User>
}