//
//  LeaderboardView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 4/9/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit

class LeaderboardView: UITableViewController {
  
  var leaderboardViewModel : LeaderboardViewModel? = nil
  var eventId : String? = nil
  var eventName : String? = nil
  
  @IBOutlet var leaderboardTable: UITableView!
    
  //  MARK: UIView Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // if eventId is nil, use default
    if (eventId == nil) {
      self.eventId = StartupService.sharedInstance.defaultEventId
    }
    
    // Setup the ViewModel
    leaderboardViewModel = LeaderboardViewModel(viewController: self)
    leaderboardViewModel?.setup(eventId:eventId!)
    
    // Setup the Tableview Delegates
    leaderboardTable.delegate = self
    leaderboardTable.dataSource = self
    leaderboardTable.tableFooterView = UIView(frame: CGRect.zero)
    let corpsNib = UINib(nibName: "LeaderboardRow", bundle: nil)
    leaderboardTable.register(corpsNib, forCellReuseIdentifier: "LeaderboardRow")
    
    leaderboardTable.setEditing(true, animated: true)
    
    // Setup the ViewController Title
//    self.title = Constants.contestTitle
    //    self.restorationIdentifier = "contest"
    
    leaderboardViewModel?.loadLeaderboard()
    
    self.refreshControl!.addTarget(self, action: #selector(LeaderboardView.refresh(_:)), for: UIControlEvents.valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.topItem?.title = "LEADERBOARD"
  }
  
  func refresh(_ refreshControl: UIRefreshControl) {
    self.leaderboardTable.reloadData()
    
    if self.refreshControl!.isRefreshing
    {
      self.refreshControl!.endRefreshing()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  /**
   reload
   */
  func reload() {
    leaderboardTable.reloadData()
  }
  
  //  MARK: Custom Methods
  
  /**
   dismiss
   Called by EBViewModel - will execute if playing from a cell
   Dismiss back to EBTabView
   */
  func dismiss() {
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  //  MARK: UITableViewDelegate - UITableViewDataSource Methods
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return leaderboardViewModel!.userScores.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardRow") as! LeaderboardRow
    cell.leaderboardView = self
    let userScore = leaderboardViewModel!.userScores[indexPath.row]
    cell.load(indexPath.row, userScore: userScore)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
}

