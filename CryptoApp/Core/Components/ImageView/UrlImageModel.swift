import Combine
import SwiftUI

class UrlImageModel: ObservableObject {
    
    @Published var image: UIImage?
    var urlString: String?
    var imageCache = ImageCacheCustom.getImageCache()
    var requestCancelable : AnyCancellable?
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
            return
        }
        
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl() {
        
        guard let urlString = urlString else {
            return
        }
        
        requestCancelable = NetworkingManager.download(from: URL(string: urlString)!)
            .sink {
                switch $0 {
                case .failure(let error): do {
                    print(error.localizedDescription)
                }
                case .finished: break
                }
            } receiveValue: { loadedImage in
                if let image = UIImage(data: loadedImage) {
                    self.imageCache.set(forKey: self.urlString ?? "", image: image)
                    self.image = image
                }
            }
    }
}
