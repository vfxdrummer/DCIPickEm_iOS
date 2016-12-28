//
//  ContestView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestView: UITableViewController {
  
  var contestViewModel : ContestViewModel? = nil
//  var corpsScores : CorpsScores = CorpsScores()
  
  @IBOutlet var contestTable: UITableView!
  
  //  MARK: UIView Lifecycle Methods
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    // Setup the ViewModel
    contestViewModel = ContestViewModel(viewController: self)
    contestViewModel?.setup()
    
    // Setup the Tableview Delegates
    contestTable.delegate = self
    contestTable.dataSource = self
    contestTable.tableFooterView = UIView(frame: CGRectZero)
    let corpsNib = UINib(nibName: "ContestRow", bundle: nil)
    contestTable.registerNib(corpsNib, forCellReuseIdentifier: "ContestRow")
    
    contestTable.setEditing(true, animated: true)
    
    // Setup the ViewController Title
//    self.title = Constants.contestTitle
    //    self.restorationIdentifier = "contest"
    
    self.refreshControl!.addTarget(self, action: #selector(ContestView.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
  }
  
  override func viewWillAppear(animated: Bool) {
  }
  
  func refresh(refreshControl: UIRefreshControl) {
    self.contestViewModel!.sort()
    self.contestTable.reloadData()
    
    if self.refreshControl!.refreshing
    {
      self.refreshControl!.endRefreshing()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //  MARK: Custom Methods
  
  /**
   load
   Called by viewDidLoad [Handles Albums Loaded Locally]
   Called by AlbumViewModel on Load Complete [Handles Albums Pulled from Remote]
   - parameter album: Album
   */
  func load(contest:Contest) {
    
  }
  
  func updateCorpsScore(index:Int, pickScore:String) {
    if (self.contestViewModel != nil) {
      self.contestViewModel!.corpsScores[index].score.pick = pickScore
      self.contestViewModel!.sort()
      self.contestTable.reloadData()
    }
  }
  
  /**
   dismiss
   Called by EBViewModel - will execute if playing from a cell
   Dismiss back to EBTabView
   */
  func dismiss() {
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  //  MARK: UITableViewDelegate - UITableViewDataSource Methods
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contestViewModel!.corpsScores.count
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    for view in cell.subviews {
      if NSStringFromClass(view.classForCoder) == "UITableViewCellReorderControl"
      {
        // Move reorder handle to the far left of the cell
        // Creates a new subview the size of the entire cell
        let movedReorderRect : CGRect = CGRectMake(0.0, 0.0, CGRectGetMaxX(view.frame), CGRectGetMaxY(view.frame))
        // Adds the reorder control view to our new subview
        let movedReorderControl : UIView = UIView(frame: movedReorderRect)
        // Adds our new subview to the cell
        movedReorderControl.addSubview(view)
        // Adds our new subview to the cell
        cell.addSubview(movedReorderControl)
        // move it to the left
        let moveLeft : CGSize = CGSizeMake(movedReorderControl.frame.size.width - view.frame.size.width, movedReorderControl.frame.size.height - view.frame.size.height)
        var transform : CGAffineTransform = CGAffineTransformIdentity
        transform = CGAffineTransformTranslate(transform, -moveLeft.width, -moveLeft.height)
        movedReorderControl.transform = transform
      }
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ContestRow") as! ContestRow
    cell.contestView = self
    cell.load(indexPath.row, corpsScore: contestViewModel!.corpsScores[indexPath.row])
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  //  MARK: UITableViewDelegate - editting / rearranging methods
  
  override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.None
  }
  
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    if (sourceIndexPath.row != destinationIndexPath.row) {
      let score = contestViewModel!.corpsScores[destinationIndexPath.row].score.pick
      contestViewModel!.corpsScores[destinationIndexPath.row].score.pick = contestViewModel!.corpsScores[sourceIndexPath.row].score.pick
      contestViewModel!.corpsScores[sourceIndexPath.row].score.pick = score
      swap(&contestViewModel!.corpsScores[sourceIndexPath.row], &contestViewModel!.corpsScores[destinationIndexPath.row])
      self.contestTable.reloadData()
    }
  }
}

