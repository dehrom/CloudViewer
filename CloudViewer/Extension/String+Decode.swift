//
//  String+Decode.swift
//  CloudViewer
//
//  Created by Валерий Коканов on 12.09.2018.
//  Copyright © 2018 my-night. All rights reserved.
//

import Foundation

extension String {
    func decode<T: Codable>(for _: T.Type) -> T? {
        guard
            let data = self.data(using: .utf8),
            let model = try? JSONDecoder().decode(T.self, from: data)
        else { return nil }
        return model
    }
}
