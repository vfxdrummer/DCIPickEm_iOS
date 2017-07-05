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
  var placementOnly : Bool = false
  
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
    let leaderboardRowNib = UINib(nibName: "LeaderboardRow", bundle: nil)
    leaderboardTable.register(leaderboardRowNib, forCellReuseIdentifier: "LeaderboardRow")
    let leaderboardMessageRowNib = UINib(nibName: "LeaderboardMessageRow", bundle: nil)
    leaderboardTable.register(leaderboardMessageRowNib, forCellReuseIdentifier: "LeaderboardMessageRow")
    
    self.refreshControl!.addTarget(self, action: #selector(LeaderboardView.refresh(_:)), for: UIControlEvents.valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.topItem?.title = (eventName != nil) ? eventName : "LEADERBOARD"
    leaderboardViewModel?.loadLeaderboard()
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
    switch (leaderboardViewModel!.hasData) {
    case true:
      return placementOnly == true ? leaderboardViewModel!.placementScores.count : leaderboardViewModel!.scoresScores.count
    case false:
      return 1
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch (leaderboardViewModel!.hasData) {
    case true:
      return 100
    case false:
      return UIScreen.main.bounds.size.height
    }
  }
  
  public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return leaderboardViewModel!.hasData ? 50.0 : 0.0
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let vw = UIView()
    let backgroundColor = UIColor(hex: "3D3935")
    vw.backgroundColor = backgroundColor
    let segmentedControl = UISegmentedControl(items: ["placement", "scores"])
    
    segmentedControl.selectedSegmentIndex = placementOnly == true ? 0 : 1
    
    // Add function to handle Value Changed events
    segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
    
    vw.addSubview(segmentedControl)
//    vw.translatesAutoresizingMaskIntoConstraints = false
    
    let xPostion:CGFloat = UIScreen.main.bounds.width / 2 - 100
    let yPostion:CGFloat = 10
    let elementWidth:CGFloat = 200
    let elementHeight:CGFloat = 30
    
    segmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
    
    return vw
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch (leaderboardViewModel!.hasData) {
    case true:
      let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardRow") as! LeaderboardRow
      cell.leaderboardView = self
      if (leaderboardViewModel!.placementScores.count > indexPath.row && leaderboardViewModel!.scoresScores.count > indexPath.row) {
        let userScore = placementOnly == true ? leaderboardViewModel!.placementScores[indexPath.row] : leaderboardViewModel!.scoresScores[indexPath.row]
        cell.load(userScore: userScore)
      }
      return cell
      
    case false:
      let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardMessageRow") as! LeaderboardMessageRow
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
  // Mark - SegmentedControl
  
//  func segmentedControlValueChanged(segment: UISegmentedControl) {
//    
//  }
  
  func segmentedValueChanged(_ sender:UISegmentedControl!)
  {
    placementOnly = sender.selectedSegmentIndex == 0 ? true : false
    reload()
  }
  
}

