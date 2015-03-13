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

        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowAudio(sender: UIButton) {
        println("User pressed the Slow Audio button.")
        playAudioAtSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        println("User pressed the Fast Audio button.")
        playAudioAtSpeed(2.5)
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        println("User pressed the Chipmunk Audio button.")
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        println("Playing audio with a pitch value of \(pitch)")
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
    
    @IBAction func stopAudioPlayback(sender: UIButton) {
        println("User pressed the Stop Audio Playback button")
        audioPlayer.stop()
    }
    
    func playAudioAtSpeed(speed: Float) {
        println("User wants to play audio at a speed of \(speed)")
        
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
