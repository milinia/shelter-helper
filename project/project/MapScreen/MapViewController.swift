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
    var shelters: [Shelter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapRegion()
        mapPresenter.loadShelters()
        shelters.append(Shelter(title: "Зоозабота",
                                coordinate:
                                    CLLocationCoordinate2D(
                                    latitude: 56.05484271675826,
                                    longitude: 49.20367529831694),
                                linkToVK: nil,
                                linkToIntagram: nil,
                                shelterId: "AWLogSNh1vWxbIYcpGWl"))
        addShelterAnnotations(shelters: shelters)
        // addShelterAnnotations(shelters: mapPresenter.getShelters())
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
        shelters.forEach { shelter in
            map.addAnnotation(shelter)
        }
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
        let shelter = shelters.first { shelter in
            shelter.coordinate.latitude == view.annotation?.coordinate.latitude
            && shelter.coordinate.longitude == view.annotation?.coordinate.longitude
        }
        // performSegue(withIdentifier: "toShelterScreen", sender: mapPresenter.getShelterByLocation(view: view))
        performSegue(withIdentifier: "toShelterScreen", sender: shelter)
    }
}
