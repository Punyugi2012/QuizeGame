//
//  MenuCollectionViewController.swift
//  QuizeGame
//
//  Created by punyawee  on 29/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit



class MenuCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        switch indexPath.row {
            case 0:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Audio", for: indexPath)
            case 1:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath)
            case 2:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Draw", for: indexPath)
            case 3:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Setting", for: indexPath)
            default:
                cell = UICollectionViewCell()
                break
        }
        return cell
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
    
//    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
//        let segue = UnwindRightToLeftSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
//        segue.perform()
//    }
    
//    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
//        let segue = UnwindRightToLeftSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
//        segue.perform()
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
