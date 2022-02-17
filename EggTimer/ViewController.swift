
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    weak var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSeleted(_ sender: UIButton) {
        
        progressBar.progress = 1.0
        
        timer?.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            secondsPassed += 1

            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            } else if secondsPassed == totalTime {
                timer?.invalidate()
            titleLabel.text = "DONE!"
                
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            

            }
        
    }
    @IBAction func stopButton(_ sender: UIButton) {
        if player.play() {
            secondsPassed += 1
            progressBar.progress = 0.0
            player.stop()
        } else {
            return
        }
        
    }
}
