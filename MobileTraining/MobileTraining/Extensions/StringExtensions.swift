//
//  StringExtensions.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 30.06.23.
//

import Foundation

extension String {
    func validateEmail() -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", StringConstants.emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
