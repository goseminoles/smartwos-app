//
// Created by Wei Zhang on 8/19/18.
// Copyright (c) 2018 BGI Group Inc. All rights reserved.
//

import Foundation

extension Models {

  struct Operation: Codable {
    let id: Int
    let name: String
    let displayName: String
    let description: String
  }

  struct User: Codable {
    let sessionId: String
    let userName: String
    let warehouse: String

    init(sessionId: String, userName: String, warehouse: String) {
      self.sessionId = sessionId
      self.userName = userName
      self.warehouse = warehouse
    }
  }

  struct Signin: Codable {
    let sessionId: String
    let userName: String
    let warehouse: String
    let operations: [Operation]
  }

}
