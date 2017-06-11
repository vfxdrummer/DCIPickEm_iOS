
//
//  ContestView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ContestView: UITableViewController, NVActivityIndicatorViewable {
  
  private var loaded : Bool = false
  var contestViewModel : ContestViewModel? = nil
  var eventId : String {
    return contestViewModel!.eventId
  }
  var eventName : String {
    return contestViewModel!.eventName
  }
  
  @IBOutlet var contestTable: UITableView!
  
  @IBOutlet weak var leaderboardButton: UIBarButtonItem!
  
  //  MARK: UIView Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the ViewModel
    contestViewModel = ContestViewModel(viewController: self)
    contestViewModel?.setup()
    
    // Setup the Tableview Delegates
    contestTable.delegate = self
    contestTable.dataSource = self
    contestTable.tableFooterView = UIView(frame: CGRect.zero)
    let corpsButtonNib = UINib(nibName: "ContestButtonRow", bundle: nil)
    contestTable.register(corpsButtonNib, forCellReuseIdentifier: "ContestButtonRow")
    let corpsOptionsNib = UINib(nibName: "ContestOptionsRow", bundle: nil)
    contestTable.register(corpsOptionsNib, forCellReuseIdentifier: "ContestOptionsRow")
    let corpsNib = UINib(nibName: "ContestRow", bundle: nil)
    contestTable.register(corpsNib, forCellReuseIdentifier: "ContestRow")
    
    // scroll tableView up a bit
    let adjustForTabbarInsets = UIEdgeInsetsMake(0, 0, 50, 0);
    contestTable.contentInset = adjustForTabbarInsets
    contestTable.scrollIndicatorInsets = adjustForTabbarInsets
    
    contestTable.setEditing(!contestViewModel!.locked, animated: true)
    
    // Left NavBar Button
    self.setLeftBackButton()
    
    // Keyboard
    self.hideKeyboardRecognizer()
    self.dismissKeyboard()
    
    // Setup the ViewController Title
    //    self.title = Constants.contestTitle
    //    self.restorationIdentifier = "contest"
    
    self.loaded = true
    
    self.refreshControl!.addTarget(self, action: #selector(ContestView.refresh(_:)), for: UIControlEvents.valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.topItem?.title = eventName
    
    // load the lineup
    print("contestViewModel?.loadLineup()")
    contestViewModel?.loadLineup()
    
    startAnimating(CGSize(width: 50, height: 50), message: "Loading Contest", type: .ballTrianglePath)
  }
  
  private func setLeftBackButton() {
    let leftButton = UIBarButtonItem(title: "<--", style: .plain, target: self, action: Selector(("toEvent")))
    //    self.navigationItem.leftBarButtonItem  = leftButton
    self.navigationController?.navigationItem.leftBarButtonItem = leftButton
  }
  
  private func toEvent() {
    CPTabView.shared?.showEvents()
  }
  
  func refresh(_ refreshControl: UIRefreshControl) {
    self.contestTable.reloadData()
    
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
    contestTable.reloadData()
    stopAnimating()
  }
  
  //  MARK: Custom Methods
  
  func updateCorpsScore(_ index:Int, pickScore:String) {
    //    print("updateCorpsScore(\(index), \(pickScore))")
    self.contestViewModel?.corpsScores[index].score.pick = pickScore
    self.contestViewModel?.sortCorpsScores(completion : { [unowned self] _ in
      self.reload()
    })
  }
  
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
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch (section) {
    case 0:
      return (contestViewModel!.locked == true) ? 0 : 2
    default:
      return contestViewModel!.corpsScores.count
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch (indexPath.section) {
    case 0:
      return 50
    default:
      return 100
    }
  }
  
  //
  //  Uncomment this to put the reorder handle on the left
  //
  //  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
  //    for view in cell.subviews {
  //      if NSStringFromClass(view.classForCoder) == "UITableViewCellReorderControl"
  //      {
  //        // Move reorder handle to the far left of the cell
  //        // Creates a new subview the size of the entire cell
  //        let movedReorderRect : CGRect = CGRect(x: 0.0, y: 0.0, width: view.frame.maxX, height: view.frame.maxY)
  //        // Adds the reorder control view to our new subview
  //        let movedReorderControl : UIView = UIView(frame: movedReorderRect)
  //        // Adds our new subview to the cell
  //        movedReorderControl.addSubview(view)
  //        // Adds our new subview to the cell
  //        cell.addSubview(movedReorderControl)
  //        // move it to the left
  //        let moveLeft : CGSize = CGSize(width: movedReorderControl.frame.size.width - view.frame.size.width, height: movedReorderControl.frame.size.height - view.frame.size.height)
  //        var transform : CGAffineTransform = CGAffineTransform.identity
  //        transform = transform.translatedBy(x: -moveLeft.width, y: -moveLeft.height)
  //        movedReorderControl.transform = transform
  //      }
  //    }
  //    cell.layoutIfNeeded()
  //  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch (indexPath.section) {
    case 0:
      switch(indexPath.row) {
      case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContestButtonRow") as! ContestButtonRow
        cell.contestView = self
        return cell
      default:
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContestOptionsRow") as! ContestOptionsRow
        cell.load((contestViewModel?.placementOnly)!)
        cell.contestView = self
        return cell
      }
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "ContestRow") as! ContestRow
      cell.contestView = self
      cell.load(indexPath.row, corpsScore: contestViewModel!.corpsScores[indexPath.row], placementOnly: (contestViewModel?.placementOnly)!, locked: contestViewModel!.locked)
      cell.layoutIfNeeded()
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
  //  MARK: UITableViewDelegate - editting / rearranging methods
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    switch (indexPath.section) {
    case 0:
      return false
    default:
      return true
    }
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.none
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    return false
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if (sourceIndexPath.row != destinationIndexPath.row) {
      print("sourceIndexPath.row \(sourceIndexPath.row), destinationIndexPath.row \(destinationIndexPath.row)")
      let i = sourceIndexPath.row
      let j = destinationIndexPath.row
      
      // retrieve local copy of corpsScores
      var corpsScores = contestViewModel!.corpsScores
      
      // capture picks for all corpsScores in order
      var picks: [String] = []
      for k in (0 ..< corpsScores.count) {
        picks.append(corpsScores[k].score.pick)
      }
      
      // shift corps placements based on whether source or detination is bigger
      if (i < j) {
        // 0 1 2 3 4
        // 0 -> 4
        // 1 2 3 4 0
        let temp = contestViewModel!.corpsScores[i]
        for k in (i..<j) {
          corpsScores[k] = contestViewModel!.corpsScores[k+1]
        }
        corpsScores[j] = temp
      } else {
        // 0 1 2 3 4
        // 4 -> 0
        // 4 0 1 2 3
        let temp = contestViewModel!.corpsScores[i]
        for k in (j+1..<i+1) {
          corpsScores[k] = contestViewModel!.corpsScores[k-1]
        }
        corpsScores[j] = temp
      }
      
      // write back scores in order to new positions
      let lowIndex = (i < j) ? i : j
      let highIndex = (j > i) ? j : i
      for k in (lowIndex..<highIndex+1) {
        corpsScores[k].score.pick = picks[k]
      }
      
      // overwrite new corpsScores object on ViewModel
      contestViewModel!.corpsScores = corpsScores
      
      self.contestTable.reloadData()
    }
  }
  
  
  // Mark - Initial scores Alert
  
  func initialScoresAlert() {
    let title = "Set Initial Placements?"
    let message = "Press yes to override score picks with default values.\n\nWould you like to continue?"
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let actionYes = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
      self.contestViewModel!.setInitialScores()
    }
    
    let actionNo = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
    }
    
    alertController.addAction(actionYes)
    alertController.addAction(actionNo)
    self.present(alertController, animated: true, completion:nil)
  }
  
  // Mark - Initial scores button
  
  func pressedInitialScores() {
    guard (contestViewModel!.locked == false) else {
      return
    }
    initialScoresAlert()
  }
  
  // Mark - set placements only Alert
  
  func initialScoresAlert(placementsOnly: Bool) {
    var title = "Set Placements Only?"
    var message = "Enable this switch to only be judged based on placements. You can reactivate scores at any time. Continue?"
    if (!placementsOnly) {
      title = "Set Scores & Placements?"
      message = "Disable switch to be judged on both scores and placements. Continue?"
    }
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let actionYes = UIAlertAction(title: "Yes", style: .default) { [unowned self] (action:UIAlertAction) in
          self.contestViewModel!.setOptionSwitch(value: placementsOnly)
    }
    
    
    let actionNo = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
      self.contestViewModel!.setOptionSwitch(value: !placementsOnly)
    }
    
    alertController.addAction(actionYes)
    alertController.addAction(actionNo)
    self.present(alertController, animated: true, completion:nil)
  }
  
  // Mark - set placements only switch
  
  func contestOptionSwitchChanged(value: Bool) {
    guard (contestViewModel!.locked == false) else {
      return
    }
    initialScoresAlert(placementsOnly: value)
  }
  
  // Mark - Leaderboard button
  
  @IBAction func pressedLeaderboardButton(_ sender: Any) {
    let leaderboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Leaderboard") as! LeaderboardView
    leaderboardVC.eventId = eventId
    show(leaderboardVC, sender: self)
  }
  
}

