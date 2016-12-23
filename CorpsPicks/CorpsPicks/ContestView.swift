//
//  ContestView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var contestViewModel : ContestViewModel? = nil
  
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
    
//    // Setup the ViewController Title
//    self.title = Constants.album
//    self.restorationIdentifier = "album"
  }
  
  override func viewWillAppear(animated: Bool) {
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
  
  /**
   dismiss
   Called by EBViewModel - will execute if playing from a cell
   Dismiss back to EBTabView
   */
  func dismiss() {
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  //  MARK: UITableViewDelegate - UITableViewDataSource Methods
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contestViewModel!.corps.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ContestRow") as! ContestRow
    cell.load(contestViewModel!.corps[indexPath.row])
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
}

