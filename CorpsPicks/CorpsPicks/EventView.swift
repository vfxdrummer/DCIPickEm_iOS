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
  private var animating: Bool = false
  private var sectionHeaderHeight: CGFloat = 50.0
  
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
    eventTable.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    let eventNib = UINib(nibName: "EventRow", bundle: nil)
    eventTable.register(eventNib, forCellReuseIdentifier: "EventRow")
    
    startAnimating()
    
    self.refreshControl!.addTarget(self, action: #selector(EventView.refresh(_:)), for: UIControlEvents.valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.topItem?.title = "CORPS PICKS EVENTS"
    
    self.eventTable.reloadData()
    
    self.eventTable.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 85.0
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.stopAnimating()
  }
  
  private func startAnimating() {
    startAnimating(CGSize(width: 50, height: 50), message: "Loading Events", type: .ballTrianglePath)
    animating = true
  }
  
  private func stopAnimating() {
    guard (animating == true) else {
      return
    }
    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    animating = false
  }
  
  private func scrollToFutureEventRow() {
    guard (eventViewModel!.pastEvents.count > 0 && eventViewModel!.futureEvents.count > 0) else {
      return
    }
    DispatchQueue.main.async {
      let index = IndexPath(row: 0, section: 1)
      self.eventTable.scrollToRow(at: index,at: .middle, animated: true)
    }
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
    self.stopAnimating()
    eventTable.reloadData()
    scrollToFutureEventRow()
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
      return eventViewModel != nil ? eventViewModel!.pastEvents.count : 0
    default:
      return eventViewModel != nil ? eventViewModel!.futureEvents.count : 0
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return sectionHeaderHeight
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = UIColor(hex: "3D3935")
    
    let titleLabel = UILabel()
    titleLabel.textColor = .white
    view.addSubview(titleLabel)
    switch (section) {
    case 0:
      titleLabel.text = "Past Events"
    default:
      titleLabel.text = "Future Events"
    }
    titleLabel.textAlignment = .center
    titleLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: sectionHeaderHeight)
    view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: sectionHeaderHeight)
    
    return view
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EventRow") as! EventRow
    cell.eventView = self
    switch (indexPath.section) {
    case 0:
      cell.load(indexPath.row, event: eventViewModel!.pastEvents[indexPath.row])
    default:
      cell.load(indexPath.row, event: eventViewModel!.futureEvents[indexPath.row])
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! EventRow
    if let event = cell.event {
      CPTabView.shared?.showContest(event: event)
      cell.isSelected = false
    }
  }
}

