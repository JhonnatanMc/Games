//
//  FilterRadioBtnCell.swift
//  Games
//
//  Created by Joonik 5 on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit

class FilterRadioBtnCell: UITableViewCell {
    
    
    private var sortByLbl   : UILabel!
    private var radioBtn    : SSRadioButton!
    private var filterType  : String = ""
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.sortByLbl = UILabel()
        self.sortByLbl.translatesAutoresizingMaskIntoConstraints = false
        self.sortByLbl.textColor = .black
        self.sortByLbl.text = ""
        self.sortByLbl.sizeToFit()
        contentView.addSubview(sortByLbl)
        
    }
    
    func setupConstraints() {
       
        NSLayoutConstraint(item: sortByLbl, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: sortByLbl, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sortByLbl, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -50).isActive = true
        NSLayoutConstraint(item: sortByLbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20).isActive = true
        
        NSLayoutConstraint(item: radioBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: radioBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: radioBtn, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: radioBtn, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -8).isActive = true
       
    }
    
    
    
    /// Add a radio Button to cell and the controller radio button
    ///
    /// - Parameter isSelected: a bool which indicate if the radio button is selected
    func createRadioButton(_ isSelected : Bool, row: Int) {
        
        radioBtn = SSRadioButton()
        let fillColor = isSelected ? ColorUtils.hexToUIColor("C1EB8F") : ColorUtils.hexToUIColor("505050")
        radioBtn.translatesAutoresizingMaskIntoConstraints = false
        radioBtn.setColor(fillColor)
        radioBtn.isUserInteractionEnabled = true
        radioBtn.isEnabled = true
        radioBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        radioBtn.tag = row
        radioBtn.isSelected = isSelected
        radioBtn.backgroundColor = .clear
        radioBtn.setStringId(self.filterType)
        self.contentView.addSubview(radioBtn)
        FilterViewController.getInstance()?.addRadioButton(radioBtn, filterType: self.filterType)
     }
    
    
    func setItem(titleStr: String, isSelected: Bool, type: String, row: Int) {
        self.sortByLbl.text = titleStr
        self.filterType = type
        self.createRadioButton(isSelected, row: row)
        self.setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
