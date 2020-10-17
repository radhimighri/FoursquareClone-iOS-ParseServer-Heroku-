//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Radhi Mighri on 17/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmo = ""
    var placeImage = UIImage()
    var placeLat = ""
    var placeLong = ""
    
    private init() {}
}
