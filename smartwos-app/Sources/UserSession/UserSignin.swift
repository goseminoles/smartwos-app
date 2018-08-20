//
// Created by Wei Zhang on 8/19/18.
// Copyright (c) 2018 BGI Group Inc. All rights reserved.
//

import Foundation

enum UserSignin {
  typealias Signin = Models.Signin

  case share

  func getUserSignin() -> Signin? {

    if let data = UserDefaults.standard.value(forKey:UserSigninKey.key) as? Data {
      return try? PropertyListDecoder().decode(Signin.self, from: data)
    }

    return nil
  }

  func saveUserSignin(signin: Signin) -> Void {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(signin), forKey:UserSigninKey.key)
  }

  func clearUserSignin() {
    UserDefaults.standard.removeObject(forKey: UserSigninKey.key)
  }

  func userSignedIn(passkey: String) -> Bool {

    if let _ = UserDefaults.standard.value(forKey: UserSigninKey.key) as? Signin {
      return true
    }

    return false
  }
}