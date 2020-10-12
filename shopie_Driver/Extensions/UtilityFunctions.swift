//
//  UtilityFunctions.swift
//  HomeMadeFood
//
//  Created by MacBook on 5/21/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import Foundation
import UIKit
//import GoogleMaps

public func ShowNetworkIndicator(flag :Bool){
    
//    UIApplication.shared.isNetworkActivityIndicatorVisible = xx
}


public func showAlert(Title:String,Message:String,delegate:UIViewController) {
    if Message == "Invalid User Token"{
        let alert = UIAlertController(title: Title, message: "Session Expired\n Please login again to continue.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        delegate.present(alert, animated: true, completion: nil)
    }
    else{
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        delegate.present(alert, animated: true, completion: nil)
    }
}

func setRootViewController(storyBoardId: String, viewControllerId: String){
    let storyBoard = UIStoryboard.init(name: storyBoardId, bundle: nil)
    let rootVC = storyBoard.instantiateViewController(withIdentifier: viewControllerId)
    let navigationController = UINavigationController(rootViewController: rootVC)

    UIApplication.shared.windows.first?.rootViewController = navigationController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
    
}

func presentGetLocationAlert(delegate: UIViewController){
    
    let locationDeniedAlert = UIAlertController(title: "", message: "Location services were denied. Please enable location services in Settings.", preferredStyle: .alert)

    let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: {
        (action) -> Void in
      let settingsURL = URL(string: UIApplication.openSettingsURLString)
        if let url = settingsURL {
            // UIApplication.shared.openURL(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

        locationDeniedAlert.dismiss(animated: true, completion: nil)
    })

    locationDeniedAlert.addAction(settingsAction)

    delegate.present(locationDeniedAlert, animated: true, completion: nil)
}

//func reverseGeocodeLocation(_ coordinate: CLLocationCoordinate2D) -> [String: Any]{
//
//    let geocoder = GMSGeocoder()
//    var responseDict = [String: Any]()
//    geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
//
//        if error == nil{
//
//            print("response: \(response)")
//            guard let address = response?.firstResult(), let lines = address.lines else {
//              return
//            }
//            responseDict["gmsAddress"] = address as GMSAddress
//            responseDict["addressLines"] = lines
//            print("responseDict: \(responseDict)")
//        }else {
//
//            print("error: \(error?.localizedDescription)")
//        }
//
//
//
//  }
//    print("response dict: \(responseDict)")
//    return responseDict
//}
