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
    
    @IBOutlet weak var articleTableView: UITableView!
    
    var feedUIInfos: [JTFeedUIInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
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
        JTFeedNetworkManager.manager.getFeed(withSuccess: { feedUIInfos in
            self.feedUIInfos = feedUIInfos
            DispatchQueue.main.async {
                self.articleTableView.reloadData()
            }
        }, withFailuer: { error in
            
        })
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
    
}
