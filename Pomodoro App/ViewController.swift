//
//  ViewController.swift
//  Pomodoro App
//
//  Created by Абзал Бухарбай on 07.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let changeBackgroundButton = UIButton(type: .system)
    private let timerLabel = UILabel()
    private let workOrBreakLabel = UILabel()
    private let playPauseButton = UIButton()
    private let stopButton = UIButton()
    private var timer: Timer?
    private var isWorking = true
    private var timeRemaining: TimeInterval = 25 * 60
    private var isPaused = true
    let circleLayer = CAShapeLayer()
    var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = UIImage(named: "bg1")
        self.view.addSubview(backgroundImageView)
        
        setupView()
        
        circleLayer.lineWidth = 7
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.withAlphaComponent(0.3  ).cgColor
        
        circleLayer.strokeEnd = 1
        view.layer.addSublayer(circleLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY - 40)
        let radius = min(view.bounds.width, view.bounds.height) * 0.3
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi / 2, endAngle: 2 * .pi - .pi / 2, clockwise: true)
        circleLayer.path = path.cgPath
    }
    
    private func setupView() {
        changeBackgroundButton.setTitle("🖊️ Focus Category", for: .normal)
        changeBackgroundButton.addTarget(self, action: #selector(changeBackgroundButtonTapped), for: .touchUpInside)
        changeBackgroundButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        changeBackgroundButton.setTitleColor(UIColor.white, for: .normal)
        changeBackgroundButton.layer.cornerRadius = 15
        changeBackgroundButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeBackgroundButton)
        
        timerLabel.text = "25:00"
        timerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        timerLabel.textColor = .white
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerLabel)
        
        workOrBreakLabel.text = "Focus on your task"
        workOrBreakLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        workOrBreakLabel.textColor = .white
        workOrBreakLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(workOrBreakLabel)
        
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        playPauseButton.tintColor = .white
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playPauseButton)
        
        stopButton.setImage(UIImage(named: "stop"), for: .normal)
        stopButton.tintColor = .white
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stopButton)
        
        NSLayoutConstraint.activate([
            changeBackgroundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            changeBackgroundButton.widthAnchor.constraint(equalToConstant: 170),
            changeBackgroundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            workOrBreakLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workOrBreakLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 8),
            
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -72),
            playPauseButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            playPauseButton.widthAnchor.constraint(equalToConstant: 60),
            
            stopButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 80),
            stopButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func changeBackgroundButtonTapped() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overCurrentContext
        bottomSheetVC.delegate = self
        present(bottomSheetVC, animated: true)
    }
    
    @objc private func playPauseButtonTapped() {
        if isPaused {
            startTimer()
            
        } else {
            pauseTimer()
        }
    }
    
    @objc private func stopButtonTapped() {
        resetTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        isPaused = false
        circleLayer.strokeColor = UIColor.white.cgColor
        playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    private func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isPaused = true
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    private func resetTimer() {
        pauseTimer()
        isWorking = !isWorking
        circleLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        circleLayer.strokeEnd = 1
        if isWorking {
            timeRemaining = 25 * 60
            workOrBreakLabel.text = "Focus on your task"
        } else {
            timeRemaining = 5 * 60
            workOrBreakLabel.text = "Break"
        }
        timerLabel.text = formattedTime(timeRemaining)
    }
    
    @objc private func timerFired() {
        timeRemaining -= 1
        if timeRemaining <= 0 {
            resetTimer()
            return
        }
        let progress = 1 - Float(timeRemaining) / Float(isWorking ? 25 * 60 : 5 * 60)
        circleLayer.strokeEnd = CGFloat(progress)
        timerLabel.text = formattedTime(timeRemaining)
    }
    
    private func formattedTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension MainViewController: BottomSheetViewControllerDelegate {
    func didSelectBackgroundImage(named imageName: String) {
        backgroundImageView.image = UIImage(named: imageName)
    }
}
