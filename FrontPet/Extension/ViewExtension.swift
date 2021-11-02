//
//  ViewExtension.swift
//  FrontPet
//
//  Created by jonnattan Choque on 1/11/21.
//

import Foundation
import UIKit

extension UIView{
    func circularStyleView(){
        self.layer.cornerRadius = 0.05 * self.bounds.size.width
        self.clipsToBounds = true
    }
}
