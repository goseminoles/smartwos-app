//
// Created by Wei Zhang on 8/15/18.
// Copyright (c) 2018 MarcoSantaDev. All rights reserved.
//

import Foundation

// Singleton class implemented using static property
class ConfigManager {

  class func shared() -> Config {

    return instance.config
  }

  private static var instance: ConfigManager = {
    let instance = ConfigManager()
    return instance
  }()

  private let config: Config

  private init() {
    let url = Bundle.main.url(forResource: "Config", withExtension: "plist")!
    let data = try! Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    config = try! decoder.decode(Config.self, from: data)
  }
}