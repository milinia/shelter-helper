//
//  AnimalDetailViewController.swift
//  project
//
//  Created by Evelina on 17.04.2022.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animalTextView: UITextView!
    var animal: Animal?

    override func viewDidLoad() {
        super.viewDidLoad()
        animalTextView.text = animal?.text
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = false 
    }
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension AnimalDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animal?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell
            else {return UICollectionViewCell()}
        cell.configure(animalPhoto: (animal?.images[indexPath.item])!)
        return cell
    }
}
