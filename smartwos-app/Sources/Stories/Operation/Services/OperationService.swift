//
// Created by Wei Zhang on 8/19/18.
// Copyright (c) 2018 BGI Group Inc. All rights reserved.
//

import Foundation
import RxSwift

struct OperationService: OperationServiceType {

  typealias Operation = OperationServiceType.Operation
  typealias User = Models.User

  func operations() -> Observable<[Operation]> {

    return Observable.create { observer -> Disposable in

      if let signin = UserSignin.share.getUserSignin() {
        observer.onNext(signin.operations)
      } else {
        observer.onError(OperationServiceError.notSignedIn)
      }

      return Disposables.create()
    }
  }

  func user() -> Observable<User> {

    return Observable.create { observer -> Disposable in

      if let signin = UserSignin.share.getUserSignin() {
        let user = User(sessionId: signin.sessionId, userName: signin.userName,
            warehouse: signin.warehouse
        )
        observer.onNext(user)
      } else {
        observer.onError(OperationServiceError.notSignedIn)
      }

      return Disposables.create()
    }
  }

}


