//
//  KeybordModel.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/25.
//

import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
