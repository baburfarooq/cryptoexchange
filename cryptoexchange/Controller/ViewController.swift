import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
        self.coinManager.getCoinPrice(for: coinManager.currencyArray[0])
    }
    
    
}

//MARK:- CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateExchangeRate(price: String, currency: String) {
       
        DispatchQueue.main.async {
            
            self.exchangeLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFaildWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK:- Double

//extension Double {
//    func format(toRound round: Int) -> Double {
//        return Double(String(format: "%.\(round)f", self)) ?? 0.0
//    }
//}

//MARK:- UIPickerView Delegate & DataSource

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrensy = self.coinManager.currencyArray[row]
        self.coinManager.getCoinPrice(for: selectedCurrensy)
    }
}

