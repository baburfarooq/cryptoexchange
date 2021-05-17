

import Foundation

struct CoinData: Decodable {
    var rate: Double
}



//
//struct Post : Codable {
//
//    var PostTitle: String
//
//    private enum CodingKeys : String, CodingKey {
//        case PostTitle = "Post Title"
//    }
//}

//struct MetaDataIntraday: Decodable {
//    let the1Information, the2Symbol, the3LastRefreshed, the4Interval: String
//    let the5OutputSize, the6TimeZone: String
//
//    enum CodingKeys: String, CodingKey {
//        case the1Information = "1. Information"
//        case the2Symbol = "2. Symbol"
//        case the3LastRefreshed = "3. Last Refreshed"
//        case the4Interval = "4. Interval"
//        case the5OutputSize = "5. Output Size"
//        case the6TimeZone = "6. Time Zone"
//    }
//}
