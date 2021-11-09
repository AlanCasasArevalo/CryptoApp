import UIKit

class ImageCacheCustom {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCacheCustom {
    private static var imageCache = ImageCacheCustom()
    static func getImageCache() -> ImageCacheCustom {
        return imageCache
    }
}
