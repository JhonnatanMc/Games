//
//  GameResultCell.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit

class GameResultCell: UITableViewCell {
    
    private var collectionView     : UICollectionView!
    private var itemSize           : CGSize!
    private var items              : Array<Game> = Array<Game>()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setGame(_ items: Array<Game>) {
        self.items  = items
        self.collectionView.reloadData()
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layoutItemSize : CGSize = Constants.ITEM_SIZE
        
        // Configure the view for the selected state
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = Constants.INTER_SPACING
        layout.minimumLineSpacing = Constants.INTER_SPACING
        layout.itemSize = layoutItemSize
        itemSize = layoutItemSize
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(GameCollectionCell.self, forCellWithReuseIdentifier: "GameCollectionCell")
        
        self.contentView.addSubview(collectionView)
        
        self.setupConstraints()
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

extension GameResultCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: GameCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionCell", for: indexPath) as? GameCollectionCell
        {
            cell.tag = indexPath.item
            cell.setGame(self.items[indexPath.item])
            cell.showLoadingSpinner()
            ImageUtils.getOriginalImage(self.items[indexPath.item].imageURL) { (image) in
                cell.hideLoadingSpinner()
                 cell.setImage(image)
            }
         
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return self.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailGameViewController = DetailGameViewController.init()
        detailGameViewController.item = self.items[indexPath.item]
        GameCatalogViewController.getInstance()?.navigationController?.pushViewController(detailGameViewController, animated: true)
        
    }
    
}
