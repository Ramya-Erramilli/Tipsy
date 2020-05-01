//
//  ViewController.swift
//  Tipsy
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var selectedTip:Double = 0.0
    var splitNumber = 2
    var tipPct:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        tipPct = sender.currentTitle
        selectedTip = (Double(String((sender.currentTitle)!).dropLast())!/100)
        //        print(selectedTip)
        
        billTextField.endEditing(true)
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumber = Int(sender.value)
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        splitNumberLabel.sizeToFit()
    }
    var totalBill = 0.0
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        if let amt = Double(billTextField.text!){
            totalBill = amt + (amt * selectedTip)
        }
        totalBill /= Double(splitNumber)
   
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var resultVC = segue.destination as! ResultsViewController
        resultVC.totalAmt = String(format: "%.2f", totalBill)
        resultVC.settings = "Split between \(splitNumber) people, with \(tipPct!) tip"
        
        
        
    }
}

