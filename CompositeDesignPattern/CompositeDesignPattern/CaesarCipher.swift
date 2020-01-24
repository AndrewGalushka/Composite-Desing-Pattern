//
//  CaesarCipher.swift
//  CompositeDesignPattern
//
//  Created by Galushka on 24.01.2020.
//  Copyright © 2020 Galushka. All rights reserved.
//

import Foundation

struct CaesarCipher {
    func caesar(string: String, shift: Int8) -> String {
        var scalarArray = [Unicode.Scalar]()
        string.unicodeScalars.forEach { (scalar) in
            
            if let shiftedScalar = self.shiftUnicodeScalar(scalar, by: shift) {
                scalarArray.append(shiftedScalar)
            }
        }
        
        return String.init(String.UnicodeScalarView(scalarArray))
    }
    
    private func shiftUnicodeScalar(_ scalar: Unicode.Scalar, by shift: Int8) -> Unicode.Scalar? {
        let function = shift.signum() == 1 ? UInt8.addingReportingOverflow.self : UInt8.subtractingReportingOverflow.self
        let shiftResult = function(UInt8(scalar.value))(UInt8(abs(shift)))
        
        return Unicode.Scalar(shiftResult.partialValue)
    }
}


