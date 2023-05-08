//
//  BottomSheetController.swift
//  Pomodoro App
//
//  Created by Абзал Бухарбай on 07.05.2023.
//

import UIKit

protocol BottomSheetViewControllerDelegate: AnyObject {
    func didSelectBackgroundImage(named imageName: String)
}

class BottomSheetViewController: UIViewController {
    
    weak var delegate: BottomSheetViewControllerDelegate?
    let buttonTitles = ["Work", "Study", "Workout", "Reading", "Meditation", "Default"]
    let backgroundImages = ["bg2", "bg3", "bg4", "bg5", "bg6", "bg1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 336))
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Focus category"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        
        [closeButton, titleLabel].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraints = [
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 336),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 15)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        let buttonWidth: CGFloat = (containerView.frame.width - 70) / 2
        let buttonHeight: CGFloat = 56
        let buttonSpacing: CGFloat = 20
        var buttonViews = [UIButton]()
        
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1.0).cgColor
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(button)
            buttonViews.append(button)
            
            if index == 0 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
                    button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
                    button.widthAnchor.constraint(equalToConstant: buttonWidth),
                    button.heightAnchor.constraint(equalToConstant: buttonHeight)
                ])
            } else if index == 1 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
                    button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
                    button.widthAnchor.constraint(equalToConstant: buttonWidth),
                    button.heightAnchor.constraint(equalToConstant: buttonHeight)
                ])
            } else if index == 2 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: buttonViews[index - 2].bottomAnchor, constant: buttonSpacing),
                    button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
                    button.widthAnchor.constraint(equalToConstant: buttonWidth),
                    button.heightAnchor.constraint(equalToConstant: buttonHeight)
                ])
            } else if index == 3 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: buttonViews[index - 2].bottomAnchor, constant: buttonSpacing),
                    button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
                    button.widthAnchor.constraint(equalToConstant: buttonWidth),
                    button.heightAnchor.constraint(equalToConstant: buttonHeight)
                ])
            } else if index == 4 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: buttonViews[index - 2].bottomAnchor, constant: buttonSpacing),
                    button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
                    button.widthAnchor.constraint(equalToConstant: buttonWidth),
                    button.heightAnchor.constraint(equalToConstant: buttonHeight)
                ])
            } else if index == 5 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: buttonViews[index - 2].bottomAnchor, constant: buttonSpacing),
                    button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
                    button.widthAnchor.constraint(equalToConstant: buttonWidth),
                    button.heightAnchor.constraint(equalToConstant: buttonHeight)
                ])
            }
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let selectedImageName = backgroundImages[sender.tag]
        delegate?.didSelectBackgroundImage(named: selectedImageName)
        dismiss(animated: true, completion: nil)
    }
}
