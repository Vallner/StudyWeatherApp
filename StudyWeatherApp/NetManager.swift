//
//  NetManager.swift
//  StudyWeatherApp
//
//  Created by Danila Savitsky on 18.05.25.
//
import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Decimal
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Decimal
    let humidity, cloud: Int
    let feelslikeC: Decimal
    let windchillC: Decimal
    let heatindexC, dewpointC: Decimal
    let visKM, visMiles: Int
    let uv, gustMph, gustKph: Decimal
    let airQuality: [String: Decimal]
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case windchillC = "windchill_c"
        case heatindexC = "heatindex_c"
        case dewpointC = "dewpoint_c"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case airQuality = "air_quality"
    }
    // MARK: - Condition
    struct Condition: Codable {
        let text, icon: String
        let code: Int
    }
}
    // MARK: - Location
    struct Location: Codable {
        let name, region, country: String
        let lat, lon: Double
        let tzID: String
        let localtimeEpoch: Int
        let localtime: String

        enum CodingKeys: String, CodingKey {
            case name, region, country, lat, lon
            case tzID = "tz_id"
            case localtimeEpoch = "localtime_epoch"
            case localtime
        }
    }


class NetManager{
    
    let jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()
   
    
    
    private let session: URLSession
    
    init(with configuration: URLSessionConfiguration){
         session = URLSession(configuration: configuration)
    }
    
    func obtainData() async throws -> Weather{
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=42a6424772284474b8c102539251805&q=Minsk&aqi=yes")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let responseData = try await session.data(for: urlRequest)
        
        return try jsonDecoder.decode(Weather.self, from: responseData.0)
        }
    func getImage(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL string: \(urlString)")
        }
        let data = try await session.data(for: URLRequest(url: url))
        return data.0
    }
    }

