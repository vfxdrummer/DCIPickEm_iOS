//
//  EventView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EventView: UITableViewController, NVActivityIndicatorViewable {
  
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
    let eventNib = UINib(nibName: "EventRow", bundle: nil)
    eventTable.register(eventNib, forCellReuseIdentifier: "EventRow")
    
    startAnimating(CGSize(width: 50, height: 50), message: "Loading Contest", type: .ballTrianglePath)
    
    self.refreshControl!.addTarget(self, action: #selector(EventView.refresh(_:)), for: UIControlEvents.valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.topItem?.title = "CORPS PICKS EVENTS"
    
    self.eventTable.reloadData()
    
    self.eventTable.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 85.0
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
    stopAnimating()
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
    return 120
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EventRow") as! EventRow
    cell.eventView = self
    cell.load(indexPath.row, event: eventViewModel!.events[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! EventRow
    if let event = eventViewModel?.events[indexPath.row] as Event? {
      CPTabView.shared?.showContest(event: event)
      cell.isSelected = false
    }
  }
}

