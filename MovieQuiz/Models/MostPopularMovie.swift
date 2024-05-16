

import UIKit

struct MostPopularMovies: Codable {
    
    private enum Keys: CodingKey {
        case errorMessage, items
    }
    let errorMessage: String
    let items: [MostPopularMovie]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.errorMessage = try container.decode(String.self, forKey: .errorMessage)
        self.items = try container.decode([MostPopularMovie].self, forKey: .items)
    }
}

struct MostPopularMovie: Codable {
    
private enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case imageURL = "image"
    }
    
    let title: String
    let rating: String
    let imageURL: URL

    // по ссылке мы получаем картинку с неверными размерами, поэтому в конце ссылки https://m.media-amazon.com/images/M/.....V1_Ratio0.6763_AL_.jpg нужно заменить значение на ._VO_UX600_.jpg
    var resizedImageURL: URL {
        let urlString = imageURL.absoluteString // создаем строку из адреса
        let imageUrlString = urlString.components(separatedBy: "._")[0] + "._VO_UX600_.jpg"
        
        guard let newURL = URL(string: imageUrlString) else {
            return imageURL
        }
        return newURL
    }

}
