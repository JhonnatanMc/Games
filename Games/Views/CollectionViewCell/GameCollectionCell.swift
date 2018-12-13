//
//  GameCollectionCell.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {
    
    fileprivate var titleLbl    : UILabel!
    internal var imageView      : UIImageView!
    private var container       : UIView!
    internal var spinner : UIActivityIndicatorView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        self.contentView.addSubview(container)
        
        self.titleLbl = UILabel()
        self.titleLbl.textAlignment = .center
        self.titleLbl.numberOfLines = 0
        self.titleLbl.lineBreakMode = .byTruncatingTail
        self.titleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.titleLbl.font = UIFont.systemFont(ofSize: 14)
        
        self.spinner = UIActivityIndicatorView(frame: self.contentView.bounds)
        self.spinner.isHidden = true
        
        self.imageView = UIImageView()
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        
        self.container.addSubview(titleLbl)
        self.container.addSubview(imageView)
        self.container.addSubview(spinner)
        
        setupConstraints()
    }
    
    func showLoadingSpinner(_ color : UIColor = .black) {
        self.spinner.color = color
        self.spinner.startAnimating()
        self.spinner.isHidden = false
    }
    
    func hideLoadingSpinner() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint(item: container, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: container, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 190).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: titleLbl, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 4).isActive = true
        NSLayoutConstraint(item: titleLbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: titleLbl, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: -2).isActive = true
        NSLayoutConstraint(item: titleLbl, attribute: .left, relatedBy: .equal, toItem: container, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: titleLbl, attribute: .right, relatedBy: .equal, toItem: container, attribute: .right, multiplier: 1, constant: -10).isActive = true
        
    }
    
    func setGame(_ item : Game) {
        self.titleLbl.text = item.name
    }
    
    func setImage(_ img: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = img
        }
    }
    
}
