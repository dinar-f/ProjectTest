//
//  BaseViewController.swift
//  ProjectTest
//
//  Created by Dinar on 09.02.2025.
//

import UIKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)
        tapGestureRecognizerAction()
        registerKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // Можно ли как о вынести setupNavigationBar в BaseViewController
 
//    // MARK: - Setup NavigationBar
//    open func setupNavigationBar(title: String) {
//        print("print")
//        self.title = title
//        navigationController?.navigationBar.prefersLargeTitles = true
//        
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .white
//        appearance.shadowColor = .clear
//        appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]
//        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
//        
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//    }
}

// MARK: - Keyboard Dismissal
extension BaseViewController {
    private func tapGestureRecognizerAction() {
        let gestureRecognizer = UITapGestureRecognizer()
        view.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Keyboard Notification
extension BaseViewController {
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            adjustForKeyboard(show: true, keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustForKeyboard(show: false, keyboardHeight: 0)
    }
    
    @objc open func adjustForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        
    }
}
