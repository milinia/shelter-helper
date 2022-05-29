//
//  ViewController.swift
//  project
//
//  Created by Evelina on 07.03.2022.
//

import UIKit
import MapKit

protocol MapPresenterProtocol: AnyObject {
    func loadShelters()
    func getShelters() -> [Shelter]
    func getShelterByLocation(view: MKAnnotationView) -> Shelter?
    func getAlertProtocolImpl() -> AlertProtocol
}

protocol MapViewProtocol: AnyObject {
    func setMapRegion()
    func addShelterAnnotations(shelters: [Shelter])
    func showAlert(alert: UIAlertController)
}

class MapViewController: UIViewController, MapViewProtocol {
    
    @IBOutlet weak var map: MKMapView!
    var mapPresenter: MapPresenterProtocol!
    //var shelters: [Shelter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapRegion()
        mapPresenter.loadShelters()
        map.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShelterScreen", let shelterToSend = sender as? Shelter {
            guard let destController = segue.destination as? ShelterViewController
            else {return}
            destController.shelter = shelterToSend
        }
    }
    func setMapRegion() {
        let latitude = CLLocationDegrees(55.780751)
        let longitude = CLLocationDegrees(49.137154)
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        map.centerToLocation(initialLocation)
    }
    func addShelterAnnotations(shelters: [Shelter]) {
        map.addAnnotations(shelters)
    }
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
private extension MKMapView {
    
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 100000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let shelters = mapPresenter.getShelters()
        
        let shelter = shelters.first { shelter in
            shelter.coordinate.latitude == view.annotation?.coordinate.latitude
            && shelter.coordinate.longitude == view.annotation?.coordinate.longitude
        }
        performSegue(withIdentifier: "toShelterScreen", sender: shelter)
    }
}
