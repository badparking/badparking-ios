//
//  FixationViewController.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 6/24/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import UIKit
import AVFoundation

class FixationViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var takePicButton: UIButton!


    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?

    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraCapture()
        // self.navigationItem.setHidesBackButton(true, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.frame = previewView.bounds
        captureSession?.startRunning()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()

    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - IBActions
    @IBAction func takePhoto(_ sender: AnyObject) {
        takePicButton.isEnabled = false

        if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProvider(data: imageData!)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)

                    // let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    // self.capturedImage.image = image
                    self.takePicButton.isEnabled = true
                }
            })
        }
    }


    // MARK - configurators
    func setupCameraCapture() {
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto

        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

        let input = try? AVCaptureDeviceInput(device: backCamera)

        if input != nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)

            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)

                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewView.layer.addSublayer(previewLayer!)
            }
        }
    }

}

