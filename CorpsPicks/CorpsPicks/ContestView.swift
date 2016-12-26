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
  var corps : [Corps] = []
  
  @IBOutlet var contestTable: UITableView!
  
  //  MARK: UIView Lifecycle Methods
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    // Setup the ViewModel
    contestViewModel = ContestViewModel(viewController: self)
    contestViewModel?.setup()
    corps = contestViewModel!.corps
    
    // Setup the Tableview Delegates
    contestTable.delegate = self
    contestTable.dataSource = self
    contestTable.tableFooterView = UIView(frame: CGRectZero)
    let corpsNib = UINib(nibName: "ContestRow", bundle: nil)
    contestTable.registerNib(corpsNib, forCellReuseIdentifier: "ContestRow")
    
    contestTable.setEditing(true, animated: true)
    
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
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contestViewModel!.corps.count
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    for view in cell.subviews {
      if NSStringFromClass(view.classForCoder) == "UITableViewCellReorderControl"
      {
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
        
//        // Creates a new subview the size of the entire cell
//        UIView *movedReorderControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(view.frame), CGRectGetMaxY(view.frame))];
//        // Adds the reorder control view to our new subview
//        [movedReorderControl addSubview:view];
//        // Adds our new subview to the cell
//        [cell addSubview:movedReorderControl];
//        // CGStuff to move it to the left
//        CGSize moveLeft = CGSizeMake(movedReorderControl.frame.size.width - view.frame.size.width, movedReorderControl.frame.size.height - view.frame.size.height);
//        CGAffineTransform transform = CGAffineTransformIdentity;
//        transform = CGAffineTransformTranslate(transform, -moveLeft.width, -moveLeft.height);
//        // Performs the transform
//        [movedReorderControl setTransform:transform];
      }
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ContestRow") as! ContestRow
    cell.load(corps[indexPath.row])
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
    let score = corps[destinationIndexPath.row].score
    corps[destinationIndexPath.row].score = corps[sourceIndexPath.row].score
    corps[sourceIndexPath.row].score = score
    swap(&corps[sourceIndexPath.row], &corps[destinationIndexPath.row])
    
    contestTable.reloadData()
  }
}

