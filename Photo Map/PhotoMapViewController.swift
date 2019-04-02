//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit


class PhotoMapViewController: UIViewController, LocationsViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //-------------------- Class Setup --------------------//
    
    // Variables
    var pickedImage: UIImage!
    
    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PMVC - In ViewDidLoad")
        // One degree of latitude is approximately 111 kilometers (69 miles) at all times.
        // San Francisco Lat, Long = latitude: 37.783333, longitude: -122.416667
        let mapCenter = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        // Set animated property to true to animate the transition to the region
        mapView.setRegion(region, animated: false)
    }
    
    //-------------------- For Camera --------------------//
    @IBAction func cameraButton(_ sender: Any) {
        print("PMVC - In CameraButton")
        //self.performSegue(withIdentifier: "fullImageSegue", sender: nil)
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
            
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("PMVC - In imagePickerController")
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        pickedImage = editedImage;
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "tagSegue", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("PMVC - In Memory warn")
    }
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("location picked")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let locationsViewController = segue.destination as! LocationsViewController
        locationsViewController.delegate = self
    }
    

}
