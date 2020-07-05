//
//  JTArticleTableViewCell.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 04/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import UIKit

class JTArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var articleContentLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleUrlLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    private var feedUIInfo: JTFeedUIInfo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }
    
    private func setupView() {
        self.avatarImageView.backgroundColor = .clear
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.height / 2.0
        self.avatarImageView.layer.borderColor = UIColor.gray.cgColor
        self.avatarImageView.layer.borderWidth = 0.5
        self.avatarImageView.clipsToBounds = true
        
        self.articleImageView.layer.borderColor = UIColor.gray.cgColor
        self.articleImageView.layer.borderWidth = 1
        self.articleImageView.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.linkTapped))
        tapGesture.numberOfTapsRequired = 1
        self.articleUrlLabel.isUserInteractionEnabled = true
        self.articleUrlLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func linkTapped() {
        guard let urlString = self.feedUIInfo.mediaUrl,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func setAvatarIage(_ imageURLString: String?) {
        guard let urlString = imageURLString else {
            self.avatarImageView.image = nil
            return
        }
        JTAsyncImageDownloader.instance.downloadImage(withURLString: urlString) { image in
            DispatchQueue.main.async {
                self.avatarImageView?.image = image
            }
        }
    }
    
    private func setArticleImage(_ imageURLString: String?) {
        guard let urlString = imageURLString else {
            self.articleImageView.image = nil
            self.articleImageViewHeight.constant = 0
            return
        }
        JTAsyncImageDownloader.instance.downloadImage(withURLString: urlString) { image in
            DispatchQueue.main.async {
                self.articleImageView?.image = image
                self.articleImageViewHeight.constant = 200
            }
        }
    }
    
    func configureCell(uiInfo: JTFeedUIInfo) {
        self.feedUIInfo = uiInfo
        self.userNameLabel.text = uiInfo.userName
        self.userDesignationLabel.text = uiInfo.userDesignation
        self.articleContentLabel.text = uiInfo.content
        self.articleTitleLabel.text = uiInfo.mediaTitle
        self.articleUrlLabel.text = uiInfo.mediaUrl
        self.likeLabel.text = uiInfo.getLikes()
        self.commentLabel.text = uiInfo.getComments()
        self.minLabel.text = uiInfo.getTime()
        self.setAvatarIage(uiInfo.avatar)
        self.setArticleImage(uiInfo.mediaImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
