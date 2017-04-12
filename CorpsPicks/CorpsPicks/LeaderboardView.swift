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
  
  @IBOutlet var leaderboardTable: UITableView!
  
  @IBOutlet weak var leaderboardButton: UIBarButtonItem!
    
  //  MARK: UIView Lifecycle Methods
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    // Setup the ViewModel
    leaderboardViewModel = LeaderboardViewModel(viewController: self)
    leaderboardViewModel?.setup(eventId:eventId!)
    
    // Setup the Tableview Delegates
    leaderboardTable.delegate = self
    leaderboardTable.dataSource = self
    leaderboardTable.tableFooterView = UIView(frame: CGRect.zero)
    let corpsNib = UINib(nibName: "ContestRow", bundle: nil)
    leaderboardTable.register(corpsNib, forCellReuseIdentifier: "ContestRow")
    
    leaderboardTable.setEditing(true, animated: true)
    
    // Setup the ViewController Title
//    self.title = Constants.contestTitle
    //    self.restorationIdentifier = "contest"
    
    leaderboardViewModel?.loadLeaderboard()
    
    self.refreshControl!.addTarget(self, action: #selector(LeaderboardView.refresh(_:)), for: UIControlEvents.valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  func refresh(_ refreshControl: UIRefreshControl) {
//    self.leaderboardViewModel!.sortUserScores()
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
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    for view in cell.subviews {
      if NSStringFromClass(view.classForCoder) == "UITableViewCellReorderControl"
      {
        // Move reorder handle to the far left of the cell
        // Creates a new subview the size of the entire cell
        let movedReorderRect : CGRect = CGRect(x: 0.0, y: 0.0, width: view.frame.maxX, height: view.frame.maxY)
        // Adds the reorder control view to our new subview
        let movedReorderControl : UIView = UIView(frame: movedReorderRect)
        // Adds our new subview to the cell
        movedReorderControl.addSubview(view)
        // Adds our new subview to the cell
        cell.addSubview(movedReorderControl)
        // move it to the left
        let moveLeft : CGSize = CGSize(width: movedReorderControl.frame.size.width - view.frame.size.width, height: movedReorderControl.frame.size.height - view.frame.size.height)
        var transform : CGAffineTransform = CGAffineTransform.identity
        transform = transform.translatedBy(x: -moveLeft.width, y: -moveLeft.height)
        movedReorderControl.transform = transform
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardRow") as! LeaderboardRow
    cell.leaderboardView = self
    cell.load(indexPath.row, userScore: leaderboardViewModel!.userScores[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
  //  MARK: UITableViewDelegate - editting / rearranging methods
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.none
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if (sourceIndexPath.row != destinationIndexPath.row) {
      let score = leaderboardViewModel!.corpsScores[destinationIndexPath.row].score.pick
      leaderboardViewModel!.corpsScores[destinationIndexPath.row].score.pick = leaderboardViewModel!.corpsScores[sourceIndexPath.row].score.pick
      leaderboardViewModel!.corpsScores[sourceIndexPath.row].score.pick = score
      swap(&leaderboardViewModel!.corpsScores[sourceIndexPath.row], &leaderboardViewModel!.corpsScores[destinationIndexPath.row])
      leaderboardViewModel!.setScorePicks()
      self.leaderboardTable.reloadData()
    }
  }
  
  // Mark - Leaderboard  button
  
  @IBAction func pressedLeaderboardButton(_ sender: Any) {
    let leaderboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Leaderboard") as! LeaderboardView
    leaderboardVC.eventId = eventId
    show(leaderboardVC, sender: self)
  }
  
}

