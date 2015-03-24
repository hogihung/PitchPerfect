//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by John F. Hogarty on 3/10/15.
//  Copyright (c) 2015 John F. Hogarty. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        println("User pressed the Slow Audio button.")
        playAudioAtSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        println("User pressed the Fast Audio button.")
        playAudioAtSpeed(2.5)
    }

    @IBAction func playDarthAudio(sender: UIButton) {
        println("User pressed the Darth Audio button.")
        playAudioWithVariablePitch(-1250)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        println("User pressed the Chipmunk Audio button.")
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func stopAudioPlayback(sender: UIButton) {
        println("User pressed the Stop Audio Playback button")
        resetAudio()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        println("Playing audio with a pitch value of \(pitch)")
        
        resetAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    func playAudioAtSpeed(speed: Float) {
        println("User wants to play audio at a speed of \(speed)")
        
        resetAudio()
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func resetAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
