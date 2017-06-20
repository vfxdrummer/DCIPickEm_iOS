//
//  CPTopView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class CPTabView: UITabBarController, UITabBarControllerDelegate {
  static var shared : CPTabView? = nil
  private var event : Event?
  private var eventId : String?
  private var eventDate : Date?
  
  @IBOutlet weak var cpNavItem: UINavigationItem!
  @IBOutlet var cpTabBar: UITabBar?
  
  override func viewDidLoad() {
    self.delegate = self
    CPTabView.shared = self
    self.eventId = StartupService.sharedInstance.defaultEventId
    setTabIconOffsets()
  }
  
  override func viewDidAppear(_ animated: Bool) {
  }
  
  private func setTabIconOffsets() {
//    cpTabBar!.items?[0].imageInsets = UIEdgeInsetsMake(8, 1, -4, -1)
//    cpTabBar!.items?[1].imageInsets = UIEdgeInsetsMake(8, 1, -4, -1)
//    cpTabBar!.items?[2].imageInsets = UIEdgeInsetsMake(8, 1, -4, -1)
  }
  
  private func setLeftNavItem() {
//    let leftButton = UIBarButtonItem(title: "<--", style: .plain, target: self, action: #selector(CPTabView.showEvents))
//    //    self.navigationItem.leftBarButtonItem  = leftButton
//    self.navigationController?.navigationItem.leftBarButtonItem = leftButton
    
  }
  
  public func showEvents() {
    if cpTabBar?.items?[0] != nil {
      self.selectedIndex = 0
    }
  }
  
  public func showContest(event: Event) {
    if cpTabBar?.items?[1] != nil {
      self.event = event
      self.eventId = event.id
      self.eventDate = event.date
      
      syncEventForViewControllers()
      self.selectedIndex = 1
    }
  }
  
  private func syncEvent(viewController: UIViewController) {
    if let _ = viewController as? ContestView,
      self.event?.id != nil {
      CurrentContestItems.sharedInstance.eventId = (self.event?.id)!
      CurrentContestItems.sharedInstance.eventName = (self.event?.name)!
      CurrentContestItems.sharedInstance.eventDate = self.event?.date
      CurrentContestItems.sharedInstance.isComplete = (self.event?.isComplete)!
    }
    
    if let leaderboardVC = viewController as? LeaderboardView {
      leaderboardVC.eventId = self.event?.id
      leaderboardVC.eventName = self.event?.name
    }
  }
  
  private func syncEventForViewControllers() {
    for vc in self.viewControllers! {
      syncEvent(viewController: vc)
    }
  }
  
  //  MARK: UITabBarDelegate Methods
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
  }
  
  func tabBarController(_ tabBarController: UITabBarController,
                        didSelect viewController: UIViewController) {
    if let vc = viewController as? EventView {
      vc.reloadInputViews()
    }
    self.syncEvent(viewController: viewController)
  }
}
