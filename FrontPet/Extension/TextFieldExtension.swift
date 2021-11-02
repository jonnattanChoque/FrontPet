//
//  TextFieldExtension.swift
//  FrontPet
//
//  Created by jonnattan Choque on 28/10/21.
//

import Foundation
import UIKit
import MaterialComponents

extension MDCOutlinedTextField{
    func setStyle(label: String, placeholder: String){
        self.label.text = label
        self.placeholder = placeholder
        self.sizeToFit()
        self.setOutlineColor(UIColor(named: "buttonsBackground")!, for: .normal)
        self.setOutlineColor(UIColor(named: "buttonsBackground")!, for: .editing)
        self.setOutlineColor(UIColor(named: "buttonsBackground")!, for: .disabled)
    }
}
