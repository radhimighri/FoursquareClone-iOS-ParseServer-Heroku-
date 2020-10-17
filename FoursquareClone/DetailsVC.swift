//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Radhi Mighri on 16/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsPlaceNameLbl: UILabel!
    @IBOutlet weak var detailsPlaceTypeLbl: UILabel!
    @IBOutlet weak var detailsPlaceAtmosphereLbl: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var chosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DEBUG: "+chosenPlaceId)
        getPlaceDetails()
        detailsMapView.delegate = self
    }
    
    func getPlaceDetails() {
        
        let query = PFQuery(className: "Places")
            .whereKey("objectId", equalTo: chosenPlaceId)
            .findObjectsInBackground { (objects, err) in
                if err != nil {
                    print("DEBUG: \(err?.localizedDescription)")
                } else {
                    if objects != nil{
                        if objects!.count > 0 {
                            //               print("DEBUG: \(objects)")
                            let chosenPlaceObject = objects![0]
                            
                            if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                                self.detailsPlaceNameLbl.text = placeName
                            }
                            if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                                self.detailsPlaceTypeLbl.text = placeType
                            }
                            if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                                self.detailsPlaceAtmosphereLbl.text = placeAtmosphere
                            }
                            if let placeLatitude = chosenPlaceObject.object(forKey: "lat") as? String {
                                if let placeLatitudeDouble = Double(placeLatitude) {
                                    self.chosenLatitude = placeLatitudeDouble
                                }
                            }
                            if let placeLongitude = chosenPlaceObject.object(forKey: "long") as? String {
                                if let placeLongitudeDouble = Double(placeLongitude) {
                                    self.chosenLongitude = placeLongitudeDouble
                                }
                            }
                            
                            if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                                imageData.getDataInBackground { (data, err) in
                                    if err == nil {
                                        if data != nil {
                                            self.detailsImageView.image = UIImage(data: data!)
                                        }
                                    }
                                }
                            }
                            
                          // MAPS
                            
                            let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                            
                            let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                            let region = MKCoordinateRegion(center: location, span: span)
                            self.detailsMapView.setRegion(region, animated: true)
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            annotation.title = self.detailsPlaceNameLbl.text!
                            annotation.subtitle = self.detailsPlaceTypeLbl.text!
                            self.detailsMapView.addAnnotation(annotation)
                            
                        }
                        
                    }
                    
                }
        }

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           if annotation is MKUserLocation {
               return nil
           }
           
           let reuseId = "pin"
           
           var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
           
           if pinView == nil {
               pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
               pinView?.canShowCallout = true
               let button = UIButton(type: .detailDisclosure)
               pinView?.rightCalloutAccessoryView = button
           } else {
               pinView?.annotation = annotation
           }
           
           return pinView
           
       }
       
       //when we clicked on the info button in the pin annotation
       func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
           if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
               let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
               
               CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                   if let placemark = placemarks {
                       
                       if placemark.count > 0 {
                           
                           let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                           let mapItem = MKMapItem(placemark: mkPlaceMark)
                           mapItem.name = self.detailsPlaceNameLbl.text
                           
                           let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                           
                           mapItem.openInMaps(launchOptions: launchOptions)
                       }
                       
                   }
               }
               
           }
       }

}
