//
//  GameCatalogViewController.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit

extension GameCatalogViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.isFilterApplied ? 1 : 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.isFilterApplied {
            return 25
        } else {
            if section == 0 {
                return self.recentGame.isEmpty ? 0 : 25
            } else if section == 1 {
                return self.popularGame.isEmpty ? 0 : 25
            } else {
                return self.gamesArray.isEmpty ? 0 : 25
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let colorView = UIView()
        
        colorView.backgroundColor = ColorUtils.hexToUIColor("dbdbdb")
        headerView.backgroundView = colorView
        headerView.tag = section
        headerView.textLabel!.textColor = UIColor.lightGray
        headerView.alpha = 0.8
        
        let titleSection = Constants.TITLE_HEADER_GAME[section]
        
        if self.isFilterApplied {
            headerView.textLabel?.text = Constants.TITLE_HEADER_GAME[3]
        } else {
            if section == 0 {
                headerView.textLabel?.text = titleSection + "(" + String(self.recentGame.count) + ")"
                
                if self.recentGame.isEmpty {
                    return nil
                } else {
                    return headerView
                }
            } else if section == 1 {
                
                headerView.textLabel?.text = titleSection + "(" + String(self.popularGame.count) + ")"
                
                if self.popularGame.isEmpty {
                    return nil
                } else {
                    return headerView
                }
            } else if section == 2 {
                
                headerView.textLabel?.text = titleSection + "(" + String(self.gamesArray.count) + ")"
                
                if self.gamesArray.isEmpty  {
                    return nil
                } else {
                    return headerView
                }
            }
        }
        
        return headerView

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if self.isFilterApplied {
            return self.view.frame.height - 126
        } else {
            if indexPath.section == 0 {
                return self.recentGame.isEmpty ? 0 : 220
            } else if indexPath.section == 1 {
                return self.popularGame.isEmpty ? 0 : 220
            } else {
                return self.gamesArray.isEmpty ? 0 : 220
            }
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        if self.isFilterApplied {
            cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")
             (cell as! FilterCell).setGame(self.filteredResult)
           
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "GameCell")
            cell.backgroundColor = ColorUtils.hexToUIColor("e8e8e8")
            cell.tag = indexPath.row
            
            switch indexPath.section {
            case 0:
                (cell as! GameResultCell).setGame(self.recentGame)
            case 1 :
                (cell as! GameResultCell).setGame(self.popularGame)
                break
            case 2 :
                (cell as! GameResultCell).setGame(self.gamesArray)
                break
            default:
                break
            }
        }
        return cell!
    }
    
}

class GameCatalogViewController: BaseViewController {
    
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var brandBtn: UIButton!
    @IBOutlet weak var brandBtnConstraints: NSLayoutConstraint!
   
    private var results             : Array<Game> = Array<Game>()
    private var gamesArray          : Array<Game> = Array<Game>()
    fileprivate var recentGame      : Array<Game> = Array<Game>()
    fileprivate var popularGame     : Array<Game> = Array<Game>()
    fileprivate var filteredResult    : Array<Game> = Array<Game>()
    static var instance             : GameCatalogViewController?
    internal var isFilterApplied    : Bool = false
    
    fileprivate var refreshControlTb :UIRefreshControl?
    fileprivate var spinnerControl : UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameCatalogViewController.instance = self
        
        self.brandBtn.layer.cornerRadius = 15
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.scrollsToTop = true
        self.tableView.register(GameResultCell.self, forCellReuseIdentifier: "GameCell")
        self.tableView.register(FilterCell.self, forCellReuseIdentifier: "filterCell")
        self.tableView.estimatedRowHeight = 220
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.backgroundColor = ColorUtils.hexToUIColor("e8e8e8")
        self.getGamesInformation()
        
        self.refreshControlTb = UIRefreshControl()
        self.tableView.addSubview(refreshControlTb!)
        
        refreshControlTb!.addTarget(self, action: #selector(getGamesInformation), for: UIControlEvents.valueChanged)
        spinnerControl = UIActivityIndicatorView(activityIndicatorStyle: .white)
        spinnerControl!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        spinnerControl!.hidesWhenStopped = true
        self.tableView.tableFooterView = spinnerControl
        refreshControlTb?.beginRefreshing()
        
        self.isFilterApplied = false
     }
    
    
    /// check if filter is applied and change the title
    func setFilterComponentsTitle() {
        if self.isFilterApplied {
            self.filterBtn.setTitle("Clear Filter", for: UIControlState.normal)
            
            self.brandBtnConstraints.constant = 0
            self.brandBtn.setTitle("", for: UIControlState.normal)
            
        } else {
            self.filterBtn.setTitle("Filter", for: UIControlState.normal)
            
            self.brandBtnConstraints.constant = 40
            self.brandBtn.setTitle("Todos", for: UIControlState.normal)
        }
    }
    
    func applyFilter(_ brandType: String, generalType: String, minimunValue: Double, maximumValue: Double) {
        // popular  brand price
        
         self.filteredResult = self.results.filter({$0.brand.lowercased() == brandType.lowercased()})
        
        if generalType.lowercased() == "popularity" {
            self.filteredResult.append(contentsOf: self.popularGame)
        }
        
        if generalType.lowercased() == "new" {
            let newGames = Array(self.results.sorted(by: {$0.createdAt > $1.createdAt }))
            self.filteredResult.append(contentsOf: newGames)
        }
        
        if generalType.lowercased() == "price" {
            let leastPriceGame = Array(self.results.sorted(by: {$0.price < $1.price }))
             self.filteredResult.append(contentsOf: leastPriceGame)
        }
        
        let orderByPrice = self.results.filter({$0.price > minimunValue && $0.price < maximumValue})
        
        self.filteredResult.append(contentsOf: orderByPrice)
        self.tableView.reloadData()
        
    }
    
    /// Get All games available
    @objc func getGamesInformation() {
        self.addSpinner()
        GameController.getGames { (games, error, errorMessage, status) in
            self.refreshControlTb?.endRefreshing()
            self.spinnerControl?.stopAnimating()
            self.removeSpinner()
            if !error {
                self.gamesArray = games
                self.results = games
                self.recentGame = Array(self.gamesArray.sorted(by: {$0.createdAt > $1.createdAt }).prefix(5))
                self.popularGame = self.gamesArray.filter({$0.popular == true})
                self.tableView.reloadData()
            } else {
                self.showAlert(errorMessage)
            }
        }
    }
    
    
    static func getInstance() -> GameCatalogViewController? {
        return instance
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    init() {
        super.init(nibName: String(describing: GameCatalogViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    @IBAction func displayFilter(_ sender: Any) {
        let minimumValueArr = Array(self.results.sorted(by: {$0.price < $1.price }))
        let vc = FilterViewController()
        vc.minimumValue = (minimumValueArr.first?.price)!
        vc.maximumValue = (minimumValueArr.last?.price)!
        self.present(vc, animated: true) {}
    }
    
    func reorderByBrand(_ brandType: String) {
        
        self.recentGame = Array(self.results.sorted(by: {$0.createdAt > $1.createdAt }).prefix(5))
        self.popularGame = self.results.filter({$0.popular == true})
        self.gamesArray = self.results
        
        self.brandBtn.setTitle(brandType, for: .normal)
        
        self.recentGame  = self.recentGame.filter({$0.brand.lowercased() == brandType.lowercased()})
        self.popularGame = self.popularGame.filter({$0.brand.lowercased() == brandType.lowercased()})
        self.gamesArray  = self.gamesArray.filter({$0.brand.lowercased() == brandType.lowercased()})
        
        self.tableView.reloadData()
    }
    
    @IBAction func filterByBrand(_ sender: UIButton) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Tap to reorder the result by your preferences.", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            actionSheetController.dismiss(animated: true, completion: nil)
        }
        
        let NintendoOption : UIAlertAction = UIAlertAction(title: "Nintendo", style: .default) { action -> Void in
            self.reorderByBrand(BrandGame.nintendo.rawValue)
        }
        
        let playStationOption : UIAlertAction = UIAlertAction(title: "PlayStation", style: .default) { action -> Void in
            self.reorderByBrand(BrandGame.playStation.rawValue)
        }
        
        let xBoxOption : UIAlertAction = UIAlertAction(title: "Xbox", style: .default) { action -> Void in
            self.reorderByBrand(BrandGame.xBox.rawValue)
        }
        
        let pcOption : UIAlertAction = UIAlertAction(title: "PC", style: .default) { action -> Void in
            self.reorderByBrand(BrandGame.pc.rawValue)
        }
        
        
        actionSheetController.addAction(NintendoOption)
        actionSheetController.addAction(playStationOption)
        actionSheetController.addAction(xBoxOption)
        actionSheetController.addAction(pcOption)
        
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        // Show the navigation bar on other view controllers
        
    }
}


