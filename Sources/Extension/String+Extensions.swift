//
//  String+Extensions.swift
//
//
//  Created by Valentin Wallet on 08/12/2023.
//

extension String {
    subscript(index: Int) -> Character {
        let index = self.index(startIndex, offsetBy: index)
        return self[index]
    }
}
