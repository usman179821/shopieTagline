//
//  UIExtension.swift
//  RideShare
//
//  Created by Muhammad Usman on 05/06/1441 AH.
//  Copyright © 1441 Macbook. All rights reserved.
//

import Foundation
import SwiftMessages

  func showSwiftMessageWithParams(theme: Theme , title: String, body: String, layout: MessageView.Layout = MessageView.Layout.cardView, position: Int = 0, completion: @escaping (Bool) -> () = { _ in } ) {
    let view = MessageView.viewFromNib(layout: layout)
    var config = SwiftMessages.Config()
    config.dimMode = .gray(interactive: true)
    if position == 0 {
      config.presentationStyle = .center
    }else {
      config.presentationStyle = .top
    }
    let HeadingFontSize : CGFloat = Env.iPad ? 30 : 25
    let bodyFontSize = HeadingFontSize - 5
    view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    view.bodyLabel?.font = UIFont.boldSystemFont(ofSize: bodyFontSize)
    view.configureDropShadow()
    view.configureTheme(theme)
    view.button?.isHidden = true
    view.configureContent(title: title, body: body)
    config.eventListeners.append({ (event) in
      if case .didHide = event {
        completion(true)
      }
    })
    SwiftMessages.show(config: config, view: view)
  }

  func showSwiftMessageWithParams(theme: Theme , title: String, body: String, durationSecs: Int = 7, layout: MessageView.Layout = MessageView.Layout.cardView, position: SwiftMessages.PresentationStyle = SwiftMessages.PresentationStyle.center,  completion: @escaping (Bool) -> () = { _ in } ) {
    let messageView = MessageView.viewFromNib(layout: layout)
    var config = SwiftMessages.Config()
    config.presentationStyle = position
    messageView.configureDropShadow()
    let titleSize :CGFloat = Env.iPad ? 25: 20
    let messageSize :CGFloat = Env.iPad ? 20: 17
    messageView.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleSize)
    messageView.bodyLabel?.font = UIFont.boldSystemFont(ofSize: messageSize)
    config.dimMode = .gray(interactive: true)
    messageView.configureTheme(theme)
    messageView.button?.isHidden = true
    messageView.buttonTapHandler = { _ in SwiftMessages.hide() }
    messageView.configureContent(title: title, body: body)
    config.duration = durationSecs == -1 ? .forever : .seconds(seconds: 7)
    messageView.iconImageView?.image = #imageLiteral(resourceName: "launch")
    messageView.iconImageView?.backgroundColor = .white
    messageView.iconImageView?.layer.cornerRadius = 6
    messageView.iconImageView?.layer.masksToBounds = true
    let size = CGSize.init(width: 50, height: 50)
    messageView.configureIcon(withSize: size , contentMode: UIView.ContentMode.center)
    messageView.button?.setTitle("Ok", for: .normal)
    messageView.button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: messageSize)
    messageView.button?.isHidden = false
    config.eventListeners.append({ (event) in
      if case .didHide = event {
        completion(true)
      }
    })
    SwiftMessages.hide()
    SwiftMessages.show(config: config, view: messageView)
  }


class Env {
  static var iPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
}

struct Fonts {
  static let sizePhone :CGFloat = 20
  static let sizePad : CGFloat = 25
  static let standardPhone = UIFont.systemFont(ofSize: sizePhone)
  static let standardPad = UIFont.systemFont(ofSize: sizePad)
  static let boldPhone = UIFont.boldSystemFont(ofSize: Fonts.sizePhone)
  static let boldPad = UIFont.boldSystemFont(ofSize: Fonts.sizePad)
  
  ///UIFont.boldSystemFont(ofSize: sizePhone + 5)
  static let h1Phone = UIFont.boldSystemFont(ofSize: sizePhone + 5)
  static let h1Pad = UIFont.boldSystemFont(ofSize: sizePad + 5)
  
  ///boldSystemFont(ofSize: sizePhone )
  static let h2Phone = UIFont.boldSystemFont(ofSize: sizePhone )
  static let h2Pad = UIFont.boldSystemFont(ofSize: sizePad )
  
}

