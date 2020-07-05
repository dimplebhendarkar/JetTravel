//
//  JTLoadingIndicator.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 05/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation
import UIKit

class JTLoadingIndicator {
    
    private var alertController: UIAlertController!
    private var activityIndicator: UIActivityIndicatorView!
    
    static let loading = JTLoadingIndicator()
    private init() { }
    
    private func showLoadingView(title: String) {
        self.alertController = UIAlertController(title: "\n\(title)", message: nil, preferredStyle: UIAlertController.Style.alert)
        self.addActivityIndicator()
    }
    
    private func addActivityIndicator() {
        let frame = self.alertController.view.bounds
        self.activityIndicator = UIActivityIndicatorView(style: .medium)
        self.activityIndicator.center = CGPoint(x: (frame.width/4)+30, y: 20)
        self.activityIndicator.color = .gray
        self.activityIndicator.startAnimating()
        self.alertController.view.addSubview(self.activityIndicator)
    }
    
    func showLoadingView(withTitle title: String, viewController: UIViewController?) {
        self.showLoadingView(title: title)
        viewController?.present(self.alertController, animated: true, completion: nil)
    }
    
    func hideLoadingView() {
        self.activityIndicator.stopAnimating()
        self.alertController.dismiss(animated: true, completion: nil)
    }
    
}
