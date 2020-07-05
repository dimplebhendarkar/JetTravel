//
//  JTFeedViewController.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 04/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import UIKit

class JTFeedViewController: UIViewController {
 
    private let cellIdentifier = "JTArticleTableViewCell"
    private var pageNumber = 1
    private var isEndPageNumber = true
    
    @IBOutlet weak var articleTableView: UITableView!
    
    var feedUIInfos: [JTFeedUIInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Article"

        self.setUpTableViewCell()
        self.setupData()
       
    }
    
    private func setUpTableViewCell() {
        let nib = UINib(nibName: "JTArticleTableViewCell", bundle: nil)
        self.articleTableView.register(nib, forCellReuseIdentifier: "JTArticleTableViewCell")
    }

    private func setupData() {
        
        self.showLoadingIndicator()
        
        JTFeedNetworkManager.manager.getFeed(withPage: self.pageNumber, withSuccess: { feedUIInfos in
            self.isEndPageNumber = feedUIInfos.count == 0 ? false : true
            self.feedUIInfos.append(contentsOf: feedUIInfos)
            DispatchQueue.main.async {
                self.hideLoadingIndicator()
                self.articleTableView.reloadData()
            }
        }, withFailuer: { error in
            DispatchQueue.main.async {
                self.hideLoadingIndicator()
                self.showErroAlertController(error?.localizedDescription)
            }
        })
    }
    
    private func showLoadingIndicator() {
        JTLoadingIndicator.loading.showLoadingView(withTitle: "Loading page \(self.pageNumber)", viewController: self)
    }
    
    private func hideLoadingIndicator() {
        JTLoadingIndicator.loading.hideLoadingView()
    }
    
    private func showErroAlertController(_ message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension JTFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedUIInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? JTArticleTableViewCell else { return UITableViewCell() }
        cell.configureCell(uiInfo: self.feedUIInfos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (self.feedUIInfos.count != 0 && ((self.feedUIInfos.count-2) == indexPath.row) && self.isEndPageNumber) {
            self.pageNumber = self.pageNumber+1
            self.setupData()
        }
    }

}
