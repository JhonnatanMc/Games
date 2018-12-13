//
//  DetailGameViewController.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

class DetailGameViewController: UIViewController {
    
    @IBOutlet weak var titleLbl             : UILabel!
    @IBOutlet weak var skuLbl               : UILabel!
    @IBOutlet weak var gameImg              : UIImageView!
    @IBOutlet weak var raitingLbl           : UILabel!
    @IBOutlet weak var downloadLbl          : UILabel!
    @IBOutlet weak var adventureLbl         : UILabel!
    @IBOutlet weak var descriptionGameTxt   : UITextView!
    
    @IBOutlet weak var priceLbl: PaddingLabel!
    internal var item : Game = Game()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        self.completeInformation()
        
        self.descriptionGameTxt.textContainerInset = UIEdgeInsetsMake(20, 10, 2, 20)
        
        
    }
    
    func completeInformation() {
        
        let thousandFormating = Int(self.item.downloads)?.formattedWithSeparator
        
        self.titleLbl.text      = self.item.name
        self.skuLbl.text        = "SKU: \(self.item.sku)"
        self.raitingLbl.text    = "Raiting: \(self.item.rating) stars"
        self.downloadLbl.text   = thousandFormating! + " downloads"
        self.adventureLbl.text  = self.item.gender.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.priceLbl.text      = "$" + String(self.item.price)
        self.descriptionGameTxt.text = self.item.description
        
        ImageUtils.getOriginalImage(self.item.imageURL) { (image) in
          self.gameImg.image = image
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//         self.priceLbl.sizeToFit()
    }
    
    init() {
        super.init(nibName: String(describing: DetailGameViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
