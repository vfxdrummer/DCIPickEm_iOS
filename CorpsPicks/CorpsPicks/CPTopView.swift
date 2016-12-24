//
//  CPTopView.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class CPTopView: UIViewController {

//  static var deepLinkSource : (String, DeepLinkType)? = nil {
//    didSet {
//      if let shared = EBTopView.shared {
//        shared.routeDeepLink(deepLinkSource!.0, type: deepLinkSource!.1)
//        // If this changes, route to the appropriate location. Useful when the app is already in existence.
//      }
//    }
//  }
//  
//  var playerViewModel : PlayerViewModel? = nil
//  var albumVM : AlbumViewModel? = nil
//  var channelVM : ChannelViewModel? = nil
//  var artistVM : ArtistViewModel? = nil
//  var playlistVM : PlaylistViewModel? = nil
//  
//  private var popupView : PopupDispatcherView? = nil
//  private var fbSDKAdapter : FBSDKAdapter? = nil
//  private var currentTrack : TrackRealm? = nil
//  private var controlsVisible : Bool = false
//  private var mainMiniControlVisible : Bool = false
//  static var shared : EBTopView? = nil
//  var playerRef : PlayerView? = nil
//  
//  var navVC : UINavigationController? {   // Used to Access the Correct NavController from the Player
//    get {
//      if let vc = self.childViewControllers.first as? UINavigationController {
//        return vc
//      }
//      return nil
//    }
//  }
//  
//  //  MARK: UIView Lifecycle Methods
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    // Setup the Popup Handler - All popups route through here
//    popupView = PopupDispatcherView()
//    popupView?.parent = self
//    popupView?.load()
//    
//    // Setup the Facebook Adapter - Handles all facebook callbacks
//    fbSDKAdapter = FBSDKAdapter()
//    fbSDKAdapter?.load(self)
//
//    // Setup the ViewModels - Done here to handle incoming Deep Links
//    albumVM = AlbumViewModel(viewController: self)
//    albumVM?.setup()
//    channelVM = ChannelViewModel(viewController: self)
//    channelVM?.setup()
//    artistVM = ArtistViewModel(viewController: self)
//    artistVM?.setup()
//    playlistVM = PlaylistViewModel(viewController: self)
//    playlistVM?.setup()
//    playerViewModel = PlayerViewModel(viewController: self)
//
//    // If Deep Link presented and app is only just launching - route the deep link
//    if let deepLink = EBTopView.deepLinkSource {
//      routeDeepLink(deepLink.0, type: deepLink.1)
//    }
//    EBTopView.shared = self
//    
//    
//    // Setup Google Sign in
//    GIDSignIn.sharedInstance().uiDelegate = self
//    
//  }
//  
//  override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//  }
//  
//  //  MARK: Custom Methods
//
//  /**
//   routeDeepLink
//   A parsed ID corresponding to an Album, Artist, Channel, or Track is passed here. This view then will launch the appropriate view, be it an ArtistView, AlbumView, or PlayerView (for tracks+channels)
//   - parameter id:   String
//   - parameter type: DeepLinkType
//   */
//  func routeDeepLink(id:String, type:DeepLinkType) {
//    switch type {
//    case DeepLinkType.Artist:
//      let artistVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Artist") as! ArtistView
//      if let vc = self.childViewControllers.first as? UINavigationController {
//        vc.popToRootViewControllerAnimated(true)
//        vc.showViewController(artistVc, sender: self)
//      }
//      self.artistVM!.loadArtist(nil, id: id)
//      break
//    case DeepLinkType.Album:
//      let albumVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Album") as! AlbumView
//      if let vc = self.childViewControllers.first as? UINavigationController {
//        vc.popToRootViewControllerAnimated(true)
//        vc.showViewController(albumVc, sender: self)
//      }
//      self.albumVM!.load(nil, id: id)
//      break
//    case DeepLinkType.Channel:
//      ChannelInterface.fetchRemoteChannel(id, withSave:true, handler: { channel in
//        let playervc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Player") as! PlayerView
//        playervc.playableChannel = channel
//        if let vc = self.childViewControllers.first as? UINavigationController {
//          playervc.parent = vc
//        }
//        AnalyticsService.collectionType = "Channel"
//        AnalyticsService.collectionID = id
//        self.channelVM!.channelLaunched(channel)
//        self.showViewController(playervc, sender: self)
//      })
//      break
//    case DeepLinkType.Track:
//      TrackRealmInterface.fetchTrack(id, handler: {
//        track in
//        let playervc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Player") as! PlayerView
//        if let vc = self.childViewControllers.first as? UINavigationController {
//          playervc.parent = vc
//        }
//        self.showViewController(playervc, sender: self)
//        AnalyticsService.collectionType = "track"
//        AnalyticsService.collectionID = id
//        self.albumVM!.loadTracks([track], type: MusicType.Track)
//      })
//      break
//    }
//    
//  }
//
//  /**
//   showAddPlaylist
//   TODO: Is a candidate for refactor since it appears in multiple places
//   Method shows a popup for a track to be added/created playlist.
//   - parameter name:   String
//   - parameter id:     String
//   - parameter track:  TrackRealm
//   - parameter source: String
//   */
//  func showAddPlaylist(name:String, id:String, track:TrackRealm, source:String? = nil) {
//
//    // Add Create Action
//    let actionController = UIAlertController(title: Constants.playlistAddTitle, message: Constants.playlistAddBody, preferredStyle: UIAlertControllerStyle.ActionSheet)
//    let createNew = UIAlertAction(title: "\(Constants.playlistAddPrefix) (\(name))", style: UIAlertActionStyle.Default, handler: { finished in
//      self.playlistVM?.createPlaylistWithAdd(name, track: track)
//      if let s = source {
//        AnalyticsService.record_GAEvent("playlists",
//          action: "playlist-track-created-\(s)"
//        )
//      }
//    })
//    actionController.addAction(createNew)
//    
//    // Add AddToExisting Action
//    _ = playlistVM?.recentlyCreatedPlaylist.map({
//      let playlist = $0
//      let action = UIAlertAction(title: playlist.playlist_name, style: UIAlertActionStyle.Default, handler: { finished in
//        self.playlistVM?.addTrackToPlaylist(track, playlist: playlist)
//        if let s = source {
//          AnalyticsService.record_GAEvent("playlists",
//            action: "playlist-track-add-\(s)"
//          )
//        }
//      })
//      actionController.addAction(action)
//    })
//
//    // Add Cancel Action
//    let cancelAction = UIAlertAction(title: Constants.cancel, style: UIAlertActionStyle.Destructive, handler: { finished in
//    })
//    actionController.addAction(cancelAction)
//    
//    // Handle iPad -> Popover
//    if let popover = actionController.popoverPresentationController { // If is IPAP
//      popover.sourceView = self.view
//      popover.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds),0,0)
//    }
//
//    // Record Analytics
//    if let s = source {
//      AnalyticsService.record_GAEvent("playlists", action: "playlist-track-launch-\(s)")
//    }
//    showViewController(actionController, sender: self)
//
//  }
//
//  //  MARK: GoogleSignInDelegate Methods
//  
//  func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//    popupView?.dismissPopup() // OnReturn -> Dismiss whatever popup was present
//  }

}
