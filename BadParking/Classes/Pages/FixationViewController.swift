//
//  FixationViewController.swift
//  BadParking
//
//  Created by Eugene Nagorny on 6/24/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import AVFoundation

class FixationViewController: BasePageViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var capturedImage2: UIImageView!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nextPageButton: NextButton!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!

    var claim = Claim()

    var captureSession: AVCaptureSession?
    var backCamera: AVCaptureDevice?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.index = 0
        setupCameraCapture()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        previewLayer?.frame = previewView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        captureSession?.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        captureSession?.stopRunning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = previewView.bounds.size
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: previewView).y / screenSize.height
            let y = 1.0 - touchPoint.location(in: previewView).x / screenSize.width
            let focusPoint = CGPoint(x: x, y: y)

            if let device = self.backCamera {
                do {
                    try device.lockForConfiguration()
                    device.focusPointOfInterest = focusPoint
                    device.focusMode = .continuousAutoFocus
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                    // just ignore
                }
            }
        }
    }

    // MARK: - IBActions
    @IBAction func takePhoto(_ sender: UIButton) {
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authStatus {
        case .authorized:
            takePictureButton.isEnabled = false
            if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo) {
                videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
                stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(sampleBuffer, error) in
                    if (sampleBuffer != nil && self.claim.photos.count < 2) {
                        let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                        let dataProvider = CGDataProvider(data: imageData! as CFData)
                        let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                        
                        let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                        
                        
                        self.claim.photos.append((Date().description, image))
                        self.updatePhotosUI()
                        
                        if self.claim.photos.count < 2 {
                            self.takePictureButton.isEnabled = true
                        }
                    }
                })
            }
        case .denied, .notDetermined, .restricted:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granded: Bool) in
                if granded == false {
                    let alert = UIAlertController (
                        title: "Увага",
                        message: "Для того що б зробити фото перейдіть у налаштування додатку і увімкніть доступ до камери",
                        preferredStyle: UIAlertControllerStyle.alert
                    )
                    alert.addAction(UIAlertAction(title: "Заборонити", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Налаштування", style: .cancel, handler: { (alert) -> Void in
                        UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    func updatePhotosUI() {
        if self.claim.photos.count == 1 {
            self.capturedImage.image = self.claim.photos[0].image
            statusLabel.text = "Зробіть фото з іншого ракурсу";
            UIView.animate(withDuration: 0.3, animations: { 
                self.infoView.alpha = 0.0
                self.imagesStackView.alpha = 1.0
            })
        } else if self.claim.photos.count == 2 {
            self.capturedImage2.image = self.claim.photos[1].image
            self.nextPageButton.isEnabled = true
        }
    }

    // MARK: - configurators
    func setupCameraCapture() {
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto

        backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

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
