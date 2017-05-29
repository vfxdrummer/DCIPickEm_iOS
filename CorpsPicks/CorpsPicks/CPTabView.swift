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
    cpTabBar!.items?[0].imageInsets = UIEdgeInsetsMake(8, 1, -4, -1)
    cpTabBar!.items?[1].imageInsets = UIEdgeInsetsMake(8, 1, -4, -1)
    cpTabBar!.items?[2].imageInsets = UIEdgeInsetsMake(8, 1, -4, -1)
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
      
      syncEventForViewControllers()
      self.selectedIndex = 1
    }
  }
  
  private func syncEvent(viewController: UIViewController) {
    if let contestVC = viewController as? ContestView,
      self.event?.id != nil {
      contestVC.eventId = self.event?.id
      contestVC.eventName = self.event?.name
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
    self.syncEvent(viewController: viewController)
  }
}
