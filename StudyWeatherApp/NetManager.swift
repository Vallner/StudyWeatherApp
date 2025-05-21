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
    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastday: [Forecastday]
}

struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
        case hour
    }
}

struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Decimal
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Decimal
    let totalprecipMm, totalprecipIn: Decimal
    let totalsnowCM: Decimal
    let avgvisKM: Decimal
    let avgvisMiles, avghumidity: Decimal
    let dailyWillItRain, dailyChanceOfRain: Int
    let dailyWillItSnow, dailyChanceOfSnow: Int
    let condition: Condition
    let uv: Decimal
//    let airQuality: AirQuality
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCM = "totalsnow_cm"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
//        case airQuality = "air_quality"
    }
}
struct AirQuality: Codable {
    let co, no2, o3, so2: Decimal?
    let pm25, pm10: Decimal?
    let usEpaIndex, gbDefraIndex: Int?
    let aqiData: String?

    enum CodingKeys: String, CodingKey {
        case co, no2, o3, so2
        case pm25 = "pm2_5"
        case pm10
        case usEpaIndex = "us-epa-index"
        case gbDefraIndex = "gb-defra-index"
        case aqiData = "aqi_data"
    }
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
    
}
// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
    let code: Int
}
    // MARK: - Location
    struct Location: Codable {
        let name, region, country: String
        let lat, lon: Decimal
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
struct Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC, tempF: Decimal
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Decimal
    let windDegree: Int
//    let windDir: WindDir
    let pressureMB: Int
    let pressureIn, precipMm, precipIn: Double
    let snowCM, humidity, cloud: Int
    let feelslikeC, feelslikeF, windchillC, windchillF: Decimal
    let heatindexC, heatindexF, dewpointC, dewpointF: Decimal
    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int
    let visKM: Decimal
    let visMiles: Decimal
    let gustMph, gustKph, uv: Decimal
//    let airQuality: AirQuality

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
//        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case snowCM = "snow_cm"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
//        case airQuality = "air_quality"
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
    
    func obtainData(for city: String) async throws -> Weather{
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=42a6424772284474b8c102539251805&q=" + city + "&days=14&aqi=yes&alerts=no")!
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

