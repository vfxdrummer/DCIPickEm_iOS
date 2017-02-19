//
//  EventView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class EventView: UITableViewController {
  
  var eventViewModel : EventViewModel? = nil
  
  @IBOutlet var eventTable: UITableView!
  
  //  MARK: UIView Lifecycle Methods
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    // Setup the ViewModel
    eventViewModel = EventViewModel(viewController: self)
    eventViewModel?.setup()
    
    // Setup the Tableview Delegates
    eventTable.delegate = self
    eventTable.dataSource = self
    eventTable.tableFooterView = UIView(frame: CGRect.zero)
    let corpsNib = UINib(nibName: "EventRow", bundle: nil)
    eventTable.register(corpsNib, forCellReuseIdentifier: "EventRow")
    
    eventTable.setEditing(true, animated: true)
    
    // Setup the ViewController Title
//    self.title = Constants.contestTitle
    //    self.restorationIdentifier = "contest"
    
    self.refreshControl!.addTarget(self, action: #selector(EventView.refresh(_:)), for: UIControlEvents.valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  func refresh(_ refreshControl: UIRefreshControl) {
    self.eventTable.reloadData()
    
    if self.refreshControl!.isRefreshing
    {
      self.refreshControl!.endRefreshing()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //  MARK: Custom Methods
  
  /**
   loadEvents
   Called by viewDidLoad [Handles Events Loaded Locally]
   Called by EventViewModel on Load Complete [Handles Events Pulled from Remote]
   - parameter events:[Event]
   */
  func loadEvents(events:[Event]) {
    
    eventTable.reloadData()
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
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return eventViewModel!.events.count
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "EventRow") as! EventRow
    cell.eventView = self
    cell.load(indexPath.row, event: eventViewModel!.events[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
}

