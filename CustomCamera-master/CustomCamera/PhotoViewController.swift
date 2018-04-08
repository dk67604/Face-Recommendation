

import UIKit
import Alamofire

class PhotoViewController: UIViewController, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = fetchedCountry[indexPath.row].country
        cell?.detailTextLabel?.text = fetchedCountry[indexPath.row].capital
        
        return cell!
    }
    
    
    var takenPhoto:UIImage?
    
    @IBOutlet weak var countryTableView: UITableView!
    var fetchedCountry = [Country]()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let availableImage = takenPhoto {
            imageView.image = availableImage
        }
        
        
        
        countryTableView.dataSource = self
        
        // parseJSON()
        pressedPOST()
        
        // uploadPersonFace(image: takenPhoto!)
        
        //  CognitiveService.instance
        
    }
    
    
    
    
    /* func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
     
     let url = "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender"
     
     let headers: HTTPHeaders = [
     /* "Authorization": "your_access_token",  in case you need authorization header */
     "Content-type": "multipart/form-data"
     ]
     
     Alamofire.upload(multipartFormData: { (multipartFormData) in
     for (key, value) in parameters {
     multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
     }
     
     if let data = imageData{
     multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
     }
     
     }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
     switch result{
     case .success(let upload, _, _):
     upload.responseJSON { response in
     print("Succesfully uploaded")
     if let err = response.error{
     onError?(err)
     return
     }
     onCompletion?(nil)
     }
     case .failure(let error):
     print("Error in upload: \(error.localizedDescription)")
     onError?(error)
     }
     }
     } */
    
    func pressedPOST() {
        
        
        //        let restEndPoint : String = "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender"
        //        guard let url = URL(string: restEndPoint) else {
        //            print("Error creating URL")
        //            return
        //        }
        //
        //
        //        var urlRequest = URLRequest(url: url)
        //        urlRequest.httpMethod = "POST"
        //        urlRequest.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        //        urlRequest.setValue("8b458d61dc6a49f2820e317d3b018b15", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        //
        //        let pngRepresentation = UIImagePNGRepresentation(takenPhoto!)
        //
        //
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        //
        //        let task = session.uploadTask(with: urlRequest, from: pngRepresentation!){ (data, response, error) in
        //
        //            if error != nil {
        //                print("Error")
        //            }
        //            else {
        //                let httpResponse = response as! HTTPURLResponse
        //                let statusCode = httpResponse.statusCode
        //                print("SUCCESS")
        //                do{
        //                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .
        //                        mutableLeaves) as! NSArray
        //
        //                    for eachFetchedCountry in fetchedData{
        //                        let eachCountry = eachFetchedCountry as! [String:Any]
        //                        let country = eachCountry["gender"] as! String
        //                        let capital = eachCountry["age"] as! String
        //
        //                        self.fetchedCountry.append(Country(country: country, capital: capital))
        //                        self.countryTableView.reloadData()
        //
        //                    }
        //
        //                }
        //                catch{
        //                    print("Error 2")
        //                }
        //            }
        //        }
        //
        //        task.resume()
        //
        
        print("Started .. ")
        var header = [String : String]()
        header["Content-Type"] = "application/json"
        header["Ocp-Apim-Subscription-Key"] = CognitiveService.apiKey
        
        let url = "https://www.biography.com/.image/t_share/MTM2OTI2NTY2Mjg5NTE2MTI5/justin_bieber_2015_photo_courtesy_dfree_shutterstock_348418241_croppedjpg.jpg"
        
        let params:[String: String] = ["url": url]
        
        let request = Alamofire.request(CognitiveService.apiUrl, method: .post, parameters: params, headers: header)
        
       
        
        print("\(request)")
        
        request.responseJSON { (response) in
            print(response)
        }
        
       
        
        
    }
    
    
    func uploadPersonFace(image: UIImage ) {
        FaceAPI.uploadFace(faceImage: image) { (result) in
            switch result {
            case .Success(_):
                print("face uploaded - ")
                
                break
            case .Failure(let error):
                print("Error uploading a face - ", error)
                
                break
            }
        }
    }
    
    
    func parseJSON() {
        fetchedCountry = []
        let url = "https://restcountries.eu/rest/v1/all"
        var request = URLRequest(url: URL (string:url)!)
        request.httpMethod = "GET"
        
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil,
                                 delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if(error != nil){
                print("Error!")
            }else{
                do{
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .
                        mutableLeaves) as! NSArray
                    
                    for eachFetchedCountry in fetchedData{
                        let eachCountry = eachFetchedCountry as! [String:Any]
                        let country = eachCountry["name"] as! String
                        let capital = eachCountry["capital"] as! String
                        
                        self.fetchedCountry.append(Country(country: country, capital: capital))
                        self.countryTableView.reloadData()
                        
                    }
                    
                }
                catch{
                    print("Error 2")
                }
            }
        }
        task.resume()
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class Country {
    
    var country : String
    var capital : String
    
    init(country : String, capital : String) {
        self.country = country
        self.capital = capital
    }
    
}


class CognitiveService {
    
    static let instance = CognitiveService()
    static let apiKey = "8b458d61dc6a49f2820e317d3b018b15" /// set in constants file
    static let apiUrl = "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender" /// set in constants file
    
    
    
}






