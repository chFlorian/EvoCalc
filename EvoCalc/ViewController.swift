//
//  ViewController.swift
//  EvoCalc
//
//  Created by florian schweizer on 02.08.16.
//  Copyright © 2016 florian schweizer. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController{

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var candyPerEvolution: UITextField!
    @IBOutlet weak var amountOfCandy: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    var candy: Int = 0
    var result: Int = 0
    var perEvo: Int = 0
    var trading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //only for testing!
        bannerView.adUnitID = "ca-app-pub-3529356434392755/7539818222" //real id from admob
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = [ "a93fbef80a16157b5008951e1132b5c1", "A1ADBAAF-EED7-40ED-8955-C650C520253C" ]
        [bannerView .load(request)]
    }
    
    func didTapView(){
        self.view.endEditing(true)
    }
    
    @IBAction func tradingSwitchChanged(_ sender: AnyObject) {
        let switcher: UISegmentedControl = sender as! UISegmentedControl
        if switcher.selectedSegmentIndex == 0 {
            trading = true
        } else {
            trading = false
        }
    }

    @IBAction func calculationButtonPressed(_ sender: AnyObject) {
        if amountOfCandy.text! != "" && candyPerEvolution.text! != "" {
            candy = Int(amountOfCandy.text!)!
            perEvo = Int(candyPerEvolution.text!)!
            if candy > perEvo && perEvo > 0 {
                result = 0
                while candy >= perEvo {
                    candy -= perEvo
                    result += 1
                    candy += 1
                    if trading {
                    candy += 1
                    }
                }
                resultLabel.text = "\(result) Evolutions with \(candy) spare Candies"
            } else {
                resultLabel.text = "Please fill in the form correctly!"
            }
        } else {
            resultLabel.text = "Please fill in the form correctly!"
        }
    }

}

