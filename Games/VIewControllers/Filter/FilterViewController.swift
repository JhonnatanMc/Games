//
//  FilterViewController.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit
import Foundation

class FilterViewController: BaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyBtn: UIButton!
    private let sectionOptionArray = Constants.FILTER_HEADER_OPTIONS
    private let firstFilterOptionArray = Constants.FILTER_FIRST_OPTION
    private let brandOptionArray = Constants.FILTER_BRAND_OPTION
    
    internal var radioBtnArray              :   [SSRadioButton?] = [SSRadioButton?]()
    internal var radioButtonController      :   SSRadioButtonsController!
    internal var radioBtnBrandArray         :   [SSRadioButton?] = [SSRadioButton?]()
    internal var radioButtonBranController  :   SSRadioButtonsController!
    
    static var instance         : FilterViewController?
    internal var maximumValue   : Double = 0.0
    internal var minimumValue   : Double = 0.0
    internal var maximumTyped   : Int = 0
    internal var minimumTyped   : Int = 0
    internal var brandRadioOp   : Int = 0
    internal var generalRadioOp : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FilterViewController.instance = self
        
        radioButtonController = SSRadioButtonsController()
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        radioButtonBranController = SSRadioButtonsController()
        radioButtonBranController!.delegate = self
        radioButtonBranController!.shouldLetDeSelect = true
        
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        tableView.separatorStyle = .singleLine
        tableView.register(FilterRadioBtnCell.self, forCellReuseIdentifier: "FilterRadioBtnCell")
        tableView.register(PriceFilterCell.self, forCellReuseIdentifier: "PriceFilterCell")
        tableView.estimatedRowHeight = 50
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.applyBtn.layer.cornerRadius = 10
        
        maximumTyped = Int(maximumValue)
        minimumTyped = Int(minimumValue)
    }
    
    
    class func getInstance() -> FilterViewController? {
        return FilterViewController.instance
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setMinimumPrice(_ price: String) {
        if !price.isEmpty {
            self.minimumTyped = Int(price)!
        } else {
            self.minimumTyped = 0
        }
        
    }
    
    func setMaximumPrice(_ price : String) {
        if !price.isEmpty {
            self.maximumTyped = Int(price)!
        } else {
            self.maximumTyped = 0
        }
    }
    
    
    /// check if a minimun value typed is less than minimun value allowed
    ///
    /// - Returns: the bool which indicate if is allowed
    func checkMinimumValueAllowed() -> Bool {
        return minimumTyped < Int(self.minimumValue)
    }
    
    
    /// check if the max value is greater than min value
    ///
    /// - Returns: Bool which indicate if is greater or no
    func checkMaximumValueAllowed() -> Bool {
        return minimumTyped > Int(self.maximumTyped)
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        
        if self.checkMinimumValueAllowed() {
            self.showAlert("It must not be less than the allowed value \( Int(self.minimumValue))")
        }
        
        if self.checkMaximumValueAllowed() {
            self.showAlert("the maximum value must exceed the minimum value \(Int(self.maximumTyped))")
        }
        
        if !self.checkMinimumValueAllowed() && !self.checkMaximumValueAllowed()  {
            
            let brandSelection  = self.brandOptionArray[self.brandRadioOp]
            let generalSelection = self.firstFilterOptionArray[self.generalRadioOp]
            
            print(brandSelection)
            print(generalSelection)
            
        }
        
    }
    
    @IBAction func closeFilter(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /// Add radio Button to Button Controller from cell
    ///
    /// - Parameters:
    ///   - radioBtn: the radio button to added
    ///   - filterType: type of filter for to know about the section where is the radioBtn
    func addRadioButton(_ radioBtn: SSRadioButton, filterType: String) {
        
        if FilterType.brand.rawValue == filterType {
            self.radioBtnBrandArray.append(radioBtn)
            self.radioButtonBranController.addButton(radioBtn)
        } else {
            self.radioBtnArray.append(radioBtn)
            self.radioButtonController.addButton(radioBtn)
        }
    }
}


extension FilterViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.backgroundColor =  ColorUtils.hexToUIColor("e8e8e8")
        headerView.textLabel?.text = sectionOptionArray[section]
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionOptionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "FilterRadioBtnCell")
            (cell as! FilterRadioBtnCell).setItem(titleStr: self.firstFilterOptionArray[indexPath.row], isSelected: indexPath.row == 0, type: FilterType.general.rawValue, row: indexPath.row)
            break
        case 1:
            cell = Bundle.main.loadNibNamed("PriceFilterCell", owner: self, options: nil)?.first as! PriceFilterCell
            (cell as! PriceFilterCell).setMinAndMaxValue(minValue: Int(self.minimumValue), MaxValue: Int(self.maximumValue))
            break
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "FilterRadioBtnCell")
            (cell as! FilterRadioBtnCell).setItem(titleStr: self.brandOptionArray[indexPath.row], isSelected: indexPath.row == 0, type: FilterType.brand.rawValue, row: indexPath.row)
            break
        default:
            break
        }
        
        cell.backgroundColor = .white
        cell!.preservesSuperviewLayoutMargins = false
        cell!.separatorInset = UIEdgeInsets.zero
        cell!.layoutMargins = UIEdgeInsets.zero
        cell!.tag = indexPath.row
        cell!.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


enum FilterType: String {
    case brand   = "brand"
    case general = "general"
}

// MARK - SSRadioButtonControllerDelegate Methods
extension FilterViewController : SSRadioButtonControllerDelegate {
    func didSelectButton(_ aButton: UIButton?) {
        if(aButton != nil){if (aButton as! SSRadioButton).getStringId() == FilterType.brand.rawValue {
            self.brandRadioOp = aButton!.tag
        } else {
            self.generalRadioOp = aButton!.tag
            }
        }
    }
}
