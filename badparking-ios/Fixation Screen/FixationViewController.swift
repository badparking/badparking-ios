//
//  FixationViewController.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 6/24/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import UIKit

class FixationViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var bigImageView: UIImageView!
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - IBActions
    @IBAction func takePhoto(_ sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        present(imagePicker, animated: true, completion: nil)
    }


    // MARK: - delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismiss(animated: true, completion: nil)
        bigImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }

}

