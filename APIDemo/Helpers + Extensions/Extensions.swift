//
//  Extensions.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/22/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerWithNib<T: UITableViewCell>(_: T.Type) {
        register(UINib(nibName: T.nibName, bundle: .main), forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.identifier)")
        }
        return cell
    }
}

extension UITableViewCell {
    class var nibName: String {
        return String(describing: self)
    }

    class var identifier: String {
        return String(describing: self)
    }

    func addSelectedBackgroundColor(_ color: UIColor, alpha: CGFloat = 1.0) {
        selectedBackgroundView = UIView(frame: bounds)
        selectedBackgroundView?.backgroundColor = color.withAlphaComponent(alpha)
    }
}

extension UIImage {
    func compressedData(_ quality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: quality.rawValue)
    }
}
