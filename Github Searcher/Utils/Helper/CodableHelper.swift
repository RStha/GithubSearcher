//
//  CodableHelper.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import Foundation
class CodableHelper {
    static var dateFormatter:DateFormatter {
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter
        }
    }
    static var decoder:JSONDecoder{
        get{
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }
    }
    static var encoder:JSONEncoder{
        get{
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            return encoder
        }
    }
}
