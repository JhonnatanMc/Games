//
//  PriceFilterCell.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/21/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit

class PriceFilterCell: UITableViewCell {

    @IBOutlet weak var maximumValue: UITextField!
    @IBOutlet weak var minimunValueTxt: UITextField!
    
    internal var maxValue  : Int = 0
    internal var minValue  : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        maximumValue.delegate = self
        minimunValueTxt.delegate = self
        
        minimunValueTxt.addTarget(self, action: #selector(isEndEdition(_:)), for: UIControlEvents.editingChanged)
        maximumValue.addTarget(self, action: #selector(isEndEdition(_:)), for: UIControlEvents.editingDidEnd)
        
       
    }
    
   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func isEndEdition(_ sender: UITextField!) {
        if sender == minimunValueTxt {
            FilterViewController.getInstance()?.setMinimumPrice(sender.text!)
        } else {
            FilterViewController.getInstance()?.setMaximumPrice(sender.text!)
        }
    }
    
    /// min/max value allowed
    ///
    /// - Parameters:
    ///   - minValue: the min value allowed
    ///   - MaxValue: the max value allowed
    func setMinAndMaxValue(minValue: Int, MaxValue: Int) {
        self.maxValue = MaxValue
        self.minValue = minValue
        self.maximumValue.text = String(maxValue)
        self.minimunValueTxt.text = String(minValue)
    }
    
}


extension PriceFilterCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        if newText.isEmpty {
            return true
        }
        else if let maxAllowed = Int(newText), (maxAllowed <= self.maxValue) {
            return true
        }
        return false
    }
}
