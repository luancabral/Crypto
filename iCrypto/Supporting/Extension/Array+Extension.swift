//
//  Array+Extension.swift
//  iCrypto
//
//  Created by Luan Cabral on 13/01/24.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        guard index >= startIndex, index < endIndex else { return nil }
        return self[index]
    }
}
