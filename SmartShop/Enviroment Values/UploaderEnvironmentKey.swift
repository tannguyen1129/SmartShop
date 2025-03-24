//
//  UploaderEnvironmentKey.swift
//  SmartShop
//
//  Created by umtlab03im07 on 24/3/25.
//

import Foundation
import SwiftUI

private struct UploaderEnvironmentKey: EnvironmentKey {
  static let defaultValue = UploaderDownloader(httpClient: HTTPClient())
}

extension EnvironmentValues {
  var uploaderDownloader: UploaderDownloader {
    get { self[UploaderEnvironmentKey.self] }
    set { self[UploaderEnvironmentKey.self] = newValue }
  }
}
