//
//  QRScannerViewController.swift
//  ProjectTest
//
//  Created by Dinar on 10.02.2025.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    private let scannerFrame: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отсканируйте QR-код"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Наведите камеру на монитор с QR-кодом"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        addSubviews()
        setupLayout()
        setupOverlay()
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        scannerFrame.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupOverlay() {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(overlayView)

        let scanRect = CGRect(
            x: (view.bounds.width - 250) / 2,
            y: (view.bounds.height - 250) / 2,
            width: 250,
            height: 250
        )

        let path = UIBezierPath(rect: overlayView.bounds)
        let cutoutPath = UIBezierPath(roundedRect: scanRect, cornerRadius: 12)
        path.append(cutoutPath)
        path.usesEvenOddFillRule = true

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        overlayView.layer.mask = maskLayer
    }
    
    private func setupCamera() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(previewLayer!, at: 0)
        
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let qrCodeString = metadataObject.stringValue {
            print("QR-код: \(qrCodeString)")
            captureSession.stopRunning()
            openVerifyViewController()
        }
    }

    private func openVerifyViewController() {
        let verifyViewController = VerifyViewController()
        navigationController?.pushViewController(verifyViewController, animated: true)
    }
}
