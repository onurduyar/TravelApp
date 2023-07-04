
<p align="center">
  <a href="https://github.com/onurduyar/TravelApp">
    <img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/logo.png" alt="Logo" width="100" height="100">
  </a>
  <h1 align="center">Travel App</h1>
  </p>
</p>


The Smart Travel Application is a mobile application designed to provide users with travel suggestions based on their current location. 
It offers information about local weather, tourist sites, restaurants, and other relevant details to enhance their travel experience. 
The main objective of this project was to demonstrate the effective use of location-based services and 
API integrations to deliver a seamless and personalized travel recommendation system.


## GitFlow Strategy
<img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/gitflow.png" alt="">


## Features

- Programmatic UI
- Generic Network Layer
- Only URLSession
- OpenWeather API, Travel Advisor API, Geoapify
- NSCache
- CustomCells
- MapView
- CoreLocation


## Project Development Process

During the development process of this project, Trello was used for project management and git version control system was used for code base management. During the project development process, I determined and assigned tasks as if I was working in a team.

<img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/trello.png" width="700" alt="">


## Screenshots 

| Splash     | HomeView    | Place             |
| ------------ | ------------- | ------------------ |
| <img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/s0.png" width="270" height = "300%" alt=""> | <img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/s1.png" width="270" height = "300%" alt="">    | <img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/s2.png" width="270" height = "300%" alt=""> |


| MapView      | Detail     |
| ------------ | ------------- |
| -<img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/s3.png" width="270" height = "300%" alt=""> | <img src="https://github.com/onurduyar/TravelApp/blob/main/Assets/s4.png" width="270" height = "300%" alt="">    |



## Code Samples

### UIImage+Extension -- NSCache

```swift

let cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func downloadImage(from url: URL?){
        guard let url else {
            return
        }
        if let image = cache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = image
            return
        }
        
        let session = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                fatalError(error.localizedDescription)
            }
            guard let data,let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
            cache.setObject(image, forKey: url.absoluteString as NSString)
        }
        task.resume()
    }
}
```
