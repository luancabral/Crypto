//
//  ViewCode.swift
//  iCrypto
//
//  Created by Luan Cabral on 13/01/24.
//

import Foundation

protocol ViewCode {
    func buildHierarchy()
    func buildConstratins()
    func setMoreConfigurations()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        buildConstratins()
        setMoreConfigurations()
    }
    
    func setMoreConfigurations() {
        //Just if need more configuration on view that assing ViewCode
    }
}
