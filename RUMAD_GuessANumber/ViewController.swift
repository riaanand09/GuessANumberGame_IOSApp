//
//  ViewController.swift
//  RUMAD_GuessANumber
//
//  Created by Ria Anand on 3/23/21.
//

import UIKit
import SAConfettiView

class ViewController: UIViewController {
    
    @IBOutlet weak var numberGuessTextField: UITextField!
    
    var numberToGuess: Int = 0
    var attemptNumber: Int = 0
    var confettiView = SAConfettiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func didTapGenerateButton(_ sender: Any) {
        
        attemptNumber = 0
        
        numberToGuess = Int.random(in: 1...100)
        
        let alert = UIAlertController(title: "Let's begin!", message: "A random number has been generated. Enter your first guess below!", preferredStyle: .alert)
        
        //let alert = UIAlertController(title: "Let's begin!", message: "A random number, \(numberToGuess) has been generated. Enter your first guess below", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapGuessButton(_ sender: Any) {
        
        if(numberToGuess == 0){
            
            let alert = UIAlertController(title: "Error!", message: "You have not generated a number to guess yet. Click the generate button before guessing!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let guessString = numberGuessTextField.text!
        
        guard let guessNumber = Int(guessString) else {
            
            let alert = UIAlertController(title: "Error!", message: "Please enter an integer", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if(!(guessNumber >= 1 && guessNumber <= 100)){
            
            let alert = UIAlertController(title: "Error!", message: "The number you have guessed, \(guessNumber), is invalid. Please enter a number between 1 and 100.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        attemptNumber+=1
        
        if(guessNumber == numberToGuess){
            
            confettiView = SAConfettiView(frame: self.view.bounds)
            confettiView.type = .Diamond
            view.addSubview(confettiView)
            confettiView.startConfetti()
            perform(#selector(stopConfetti), with: nil, afterDelay: 2)
            perform(#selector(removeConfettiFromView), with: nil, afterDelay:7)
            
            let alert = UIAlertController(title: "You won!", message: "You have guessed the correct number, \(numberToGuess), at attempt #\(attemptNumber). Click generate to play again!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            numberToGuess = 0
            attemptNumber = 0
        }
        else{
            
            if(attemptNumber == 5){
                
                let alert = UIAlertController(title: "You lost!", message: "You have reached attempt #\(attemptNumber) without guessing correctly. The secret number was \(numberToGuess). Click generate to play again with a new number!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                numberToGuess = 0
                attemptNumber = 0
                
            }
            else if(guessNumber > numberToGuess){
                
                let alert = UIAlertController(title: "Attempt #\(attemptNumber): Incorrect guess", message: "The number you have guessed is too high. Try entering a smaller number.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(guessNumber < numberToGuess){
                
                let alert = UIAlertController(title: "Attempt #\(attemptNumber): Incorrect guess", message: "The number you have guessed is too low. Try entering a larger number.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    @objc func stopConfetti(){
        confettiView.stopConfetti()
    }
    
    @objc func removeConfettiFromView(){
        confettiView.removeFromSuperview()
    }
}

