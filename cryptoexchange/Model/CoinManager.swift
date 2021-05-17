//
//  CoinManager.swift
//  ByteCoin
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdateExchangeRate(price: String, currency: String)
    func didFaildWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    

    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/DOGE"
        let apiKey = "0C442F0C-0B3C-40AF-8797-E61329E06E27"

        let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
        
        func getCoinPrice(for currency: String) {
            
            let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
            print(urlString)
    
    
//        let baseURL = "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=doge&apikey=E1FJ3GZTWFZWQVIQ"
//    //&to_currency=CNY
//
//   // let apiKey = "0C442F0C-0B3C-40AF-8797-E61329E06E27"
//
//    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
//
//    func getCoinPrice(for currency: String) {
//        let urlString = "\(baseURL)&to_currency=\(currency)"
//        //performRequest(urlString: urlString)
//        print(urlString)
    
        if let url = URL(string: urlString) {
                    
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if error != nil {
                            self.delegate?.didFaildWithError(error: error!)
                            return
                        }
                        
                        if let safeData = data {
                            if let bitcoinPrice = self.parseJSON(safeData) {
                                let priceString = String(format: "%.2f", bitcoinPrice)
                                self.delegate?.didUpdateExchangeRate(price: priceString, currency: currency)
                            }
                        }
                    }
                    task.resume()
                }
            }
            
            func parseJSON(_ data: Data) -> Double? {
                
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(CoinData.self, from: data)
                    let lastPrice = decodedData.rate
                    print(lastPrice)
                    return lastPrice
                    
                } catch {
                    delegate?.didFaildWithError(error: error)
                    return nil
                }
            }
            
        }
