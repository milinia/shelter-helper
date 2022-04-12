//
//  MapAssembly.swift
//  project
//
//  Created by Evelina on 17.03.2022.
//

import Foundation
import UIKit

class MapAssembly: NSObject{
    
    @IBOutlet weak var mapViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = mapViewController as? MapViewController else {return}
        let mapPresenter = MapPresenter()
        
        view.mapPresenter = mapPresenter
        mapPresenter.mapView = view
    }
}
