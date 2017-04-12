//
//  HomeVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var vwTop: UIView!
    @IBOutlet var vwTopBottom: UIView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblRoofTop: UIButton!
    @IBOutlet var btnLogOut: UIButton!
    @IBOutlet var imgWeather: UIImageView!
    @IBOutlet var collectionViewHome: UICollectionView!
    @IBOutlet var viewContext: UIView!
    @IBOutlet var tblSelectRoofTop: UITableView!
    @IBOutlet var vwContextHeight: NSLayoutConstraint!
    @IBOutlet var imgLogo: UIImageView!
    
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    
    let locationManager = CLLocationManager()
    let QUERY_PREFIX = "https://query.yahooapis.com/v1/public/yql?q="
    let QUERY_SUFFIX = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewHome.delegate = self
        collectionViewHome.dataSource = self
        collectionViewHome.register(UINib(nibName: "homeScreenCell", bundle: nil), forCellWithReuseIdentifier: "homeScreenCell")
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        self.collectionViewHome.addGestureRecognizer(longPressGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        tapGesture.delegate = self
        tblSelectRoofTop.dataSource = self
        tblSelectRoofTop.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = kCLDistanceFilterNone
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startMonitoringSignificantLocationChanges()
            self.locationManager.startUpdatingLocation()
        } else {
            showAlertView(title: "Message", message: "Location services are not enabled", view: self)
        }
        self.imgLogo.contentMode = (Screen.device == .pad) ? .topLeft : .scaleAspectFit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLayoutSubviews() {
        //collectionViewHome.reloadData()
    }
    
    // MARK: CollectionView Method(s)
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.dashBoardTiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeScreenCell", for: indexPath) as? homeScreenCell
        let str = appDelegate.dashBoardTiles[indexPath.row] as! String
        cell?.lbCell.text = str
        var color = UIColor.orange
        if str == DashBoardMenu.customer{
            color = DashBoardMenu.customerTilesColor
            cell?.imgViewCell.image = #imageLiteral(resourceName: "customer")
        }else if str == DashBoardMenu.dlScan{
            color = DashBoardMenu.dlScanTilesColor
            cell?.imgViewCell.image = #imageLiteral(resourceName: "dlscan")
        }else if str == DashBoardMenu.dashboard{
            color = DashBoardMenu.dashboardTilesColor
            cell?.imgViewCell.image = #imageLiteral(resourceName: "home")
        }else if str == DashBoardMenu.setting{
            color = DashBoardMenu.settingTilesColor
            cell?.imgViewCell.image = #imageLiteral(resourceName: "settings")
        }else if str == DashBoardMenu.inventory{
            color = DashBoardMenu.inventoryTilesColor
            cell?.imgViewCell.image = #imageLiteral(resourceName: "inventory")
        }
        cell?.vwBack.backgroundColor = color
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = collectionViewHome.frame.size.width/3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionViewHome.cellForItem(at: indexPath) as? homeScreenCell
        if let itemName = appDelegate.dashBoardTiles[indexPath.row] as? String{
            appDelegate.selectedMenu = itemName
            if itemName == DashBoardMenu.dashboard{
                let vc = TabbarVC()
                //                self.view.window?.rootViewController = vc
                self.navigationController?.pushViewController(vc, animated: true)
            }else if itemName == DashBoardMenu.dlScan{
                let vc = DLScanVC(nibName: "DLScanVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if itemName == DashBoardMenu.inventory{
                let vc = InventoryVC(nibName: "InventoryVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if itemName == DashBoardMenu.customer{
                let vc = CustomerListVC(nibName: "CustomerListVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if itemName == DashBoardMenu.setting{
                let vc = SettingsVC(nibName: "SettingsVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let obj = appDelegate.dashBoardTiles.object(at: sourceIndexPath.row) as! String
        appDelegate.dashBoardTiles.removeObject(at: sourceIndexPath.row)
        appDelegate.dashBoardTiles.insert(obj, at: destinationIndexPath.row)
    }
    
    // Mark: Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Temp"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.lblRoofTop.setTitle("Temp", for: .normal)
        if !self.viewContext.isHidden{
            self.viewContext.isHidden = true
        }
        self.view.removeGestureRecognizer(tapGesture)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if  touch.view! == self.viewContext || touch.view!.superview! == self.viewContext || touch.view!.superview!.superview!.superview! == self.tblSelectRoofTop || touch.view!.superview! == self.tblSelectRoofTop  || touch.view!.superview!.superview! == self.tblSelectRoofTop{
            return false
        }
        return true
    }
    
    // MARK: Interface design
    
    func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        btnLogOut.layer.borderColor = UIColor.white.cgColor
        btnLogOut.layer.borderWidth = 1.5
        btnLogOut.layer.cornerRadius = 5
        vwTop.backgroundColor = AppColor.theamColor
        vwTopBottom.backgroundColor = AppColor.theamDarkColor
        viewContext.isHidden = true
        viewContext.layer.cornerRadius = 3
        viewContext.layer.shadowColor = UIColor.gray.cgColor
        viewContext.layer.shadowOffset = CGSize.zero
        viewContext.layer.shadowOpacity = 1
        viewContext.layer.shadowRadius = 3
        viewContext.layer.shadowPath = UIBezierPath(rect: self.viewContext.bounds).cgPath
        
    }
    
    // MARK: Outlet Action
    
    @IBAction func handleBtnLogOut(_ sender: Any) {
        if let viewControllers = self.navigationController?.viewControllers{
            for _ in viewControllers{
                _ = self.navigationController?.popViewController(animated: false)
            }
        }
        self.hidesBottomBarWhenPushed = true
        appDelegate.logut()
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func handleBtnRooftop(_ sender: UIButton) {
        self.view.addGestureRecognizer(tapGesture)
        viewContext.isHidden = false
        self.vwContextHeight.constant = 40 * 5
        self.view.bringSubview(toFront: self.viewContext)
        
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionViewHome.indexPathForItem(at: gesture.location(in: self.collectionViewHome)) else {
                break
            }
            if #available(iOS 9.0, *){
                collectionViewHome.beginInteractiveMovementForItem(at: selectedIndexPath)
            }
        case UIGestureRecognizerState.changed:
            if #available(iOS 9.0, *){
                collectionViewHome.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            }
        case UIGestureRecognizerState.ended:
            if #available(iOS 9.0, *){
                collectionViewHome.endInteractiveMovement()
            }
        default:
            if #available(iOS 9.0, *){
                collectionViewHome.cancelInteractiveMovement()
            }
        }
    }
    
    func handleTapGesture(_ sender: UITapGestureRecognizer){
        if !self.viewContext.isHidden{
            self.viewContext.isHidden = true
        }
        self.view.removeGestureRecognizer(tapGesture)
    }
    
    // MARK:- Location Delegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        self.geocoderForCity(lat: coord.latitude, long: coord.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
        print("ERROR:\(error)")
    }
    
    //weather api
    func geocoderForCity(lat: Double,long:Double) {
        let geocoder = CLGeocoder()
        let appLocation = CLLocation(latitude: lat, longitude: long)
        geocoder.reverseGeocodeLocation(appLocation, completionHandler:
            {(placemarks, error) in
                DispatchQueue.main.async(execute: {() -> Void in
                    // do stuff with placemarks on the main thread
                    if placemarks?.count == 1 {
                        let place: CLPlacemark? = placemarks?[0]
                        let zipString: String? = place?.locality
                        appDelegate.appCityLocation = zipString
                        //let strAddrssOFLOcation = "\(place?.name) \(place?.thoroughfare) \(place?.locality) \(place?.country)"
                        self.performSelector(inBackground: #selector(self.getWeatherInformation), with: nil)
                    }
                })
        })
    }
    
    func getWeatherInformation() {
        let queryPlace: String = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(appDelegate.appCityLocation!)\") and u='f'"
        self.queryPlace(queryPlace)
        DispatchQueue.main.async(execute: {() -> Void in
            self.setWeatherImage()
        })
    }
    
    func queryPlace(_ statement: String) {
        let query = "\(QUERY_PREFIX)\(statement.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!)\(QUERY_SUFFIX)"
        let jsonData: Data? = try! String(contentsOf: URL(string: query)!, encoding: String.Encoding.utf8).data(using: String.Encoding.utf8)
        
        do {
            if let json:NSMutableDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableDictionary
            {
                appDelegate.temprature = json
                
                if let query = appDelegate.temprature.value(forKey:"query"){
                    if let results = (query as AnyObject).value(forKey:"results"){
                        if let channel = (results as AnyObject).value(forKey:"channel"){
                            if let item = (channel as AnyObject).value(forKey:"item"){
                                if let condition = (item as AnyObject).value(forKey:"condition"){
                                    if let temp = (condition as AnyObject).value(forKey:"temp"){
                                        
                                        //   self.lblTemp.text = "\(temp)℉"
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        } catch let error as NSError {
            print(error)
            return
        }
    }
    
    func setWeatherImage() {
        if let query =  appDelegate.temprature.value(forKey:"query"){
            if let results = (query as AnyObject).value(forKey:"results"){
                if let channel = (results as AnyObject).value(forKey:"channel"){
                    if let item = (channel as AnyObject).value(forKey:"item"){
                        if let condition = (item as AnyObject).value(forKey:"condition"){
                            if let strCode = Int(((condition as AnyObject).value(forKey:"code") as? String)!){
                                /*  switch (strCode)
                                 {
                                 case 0:
                                 self.imgWeather.image = UIImage(named: "tornado.png")
                                 break;
                                 case 1:
                                 self.imgWeather.image = UIImage(named: "severe_thunderstorms.png")
                                 break;
                                 case 2:
                                 self.imgWeather.image = UIImage(named: "hurricane.png")
                                 break;
                                 case 3:
                                 self.imgWeather.image = UIImage(named: "severe_thunderstorms.png")
                                 break;
                                 case 4:
                                 self.imgWeather.image = UIImage(named: "thunderstorms.png")
                                 break;
                                 case 5:
                                 self.imgWeather.image = UIImage(named: "mixed_rain_and_snow.png")
                                 break;
                                 case 6:
                                 self.imgWeather.image = UIImage(named: "mixed_rain_sleet.png")
                                 break;
                                 case 7:
                                 self.imgWeather.image = UIImage(named: "mixed_rain_sleet.png")
                                 break;
                                 case 8:
                                 self.imgWeather.image = UIImage(named: "freezing_drizzle.png")
                                 break;
                                 case 9:
                                 self.imgWeather.image = UIImage(named: "drizzle.png")
                                 break;
                                 case 10:
                                 self.imgWeather.image = UIImage(named: "freezing_rain.png")
                                 break;
                                 case 11:
                                 self.imgWeather.image = UIImage(named: "showers.png")
                                 break;
                                 case 12:
                                 self.imgWeather.image = UIImage(named: "showers.png")
                                 break;
                                 case 13:
                                 self.imgWeather.image = UIImage(named: "snow_flurries.png")
                                 break;
                                 case 14:
                                 self.imgWeather.image = UIImage(named: "light_snow_showers.png")
                                 break;
                                 case 15:
                                 self.imgWeather.image = UIImage(named: "blowing_snow.png")
                                 break;
                                 case 16:
                                 self.imgWeather.image = UIImage(named: "snow.png")
                                 break;
                                 case 17:
                                 self.imgWeather.image = UIImage(named: "hail.png")
                                 break;
                                 case 18:
                                 self.imgWeather.image = UIImage(named: "sleet.png")
                                 break;
                                 case 19:
                                 self.imgWeather.image = UIImage(named: "dust.png")
                                 break;
                                 case 20:
                                 self.imgWeather.image = UIImage(named: "foggy.png")
                                 break;
                                 case 21:
                                 self.imgWeather.image = UIImage(named: "haze.png")
                                 break;
                                 case 22:
                                 self.imgWeather.image = UIImage(named: "haze.png")
                                 break;
                                 case 23:
                                 self.imgWeather.image = UIImage(named: "blustery.png")
                                 break;
                                 case 24:
                                 self.imgWeather.image = UIImage(named: "windy.png")
                                 break;
                                 case 25:
                                 self.imgWeather.image = UIImage(named: "cold.png")
                                 break;
                                 case 26:
                                 self.imgWeather.image = UIImage(named: "cloudy.png")
                                 break;
                                 case 27:
                                 self.imgWeather.image = UIImage(named: "mostly_cloudy_(night).png")
                                 break;
                                 case 28:
                                 self.imgWeather.image = UIImage(named: "mostly_cloudy_(day).png")
                                 break;
                                 case 29:
                                 self.imgWeather.image = UIImage(named: "partly_cloudy_(night).png")
                                 break;
                                 case 30:
                                 self.imgWeather.image = UIImage(named: "partly_cloudy_(day).png")
                                 break;
                                 case 31:
                                 self.imgWeather.image = UIImage(named: "clear_(night).png")
                                 break;
                                 case 32:
                                 self.imgWeather.image = UIImage(named: "sunny.png")
                                 break;
                                 case 33:
                                 self.imgWeather.image = UIImage(named: "sunny.png")
                                 break;
                                 case 34:
                                 self.imgWeather.image = UIImage(named: "sunny.png")
                                 break;
                                 case 35:
                                 self.imgWeather.image = UIImage(named: "mixed_rain_hail.png")
                                 break;
                                 case 36:
                                 self.imgWeather.image = UIImage(named: "sunny.png")
                                 default:
                                 self.imgWeather.image = UIImage()
                                 }
                                 */
                            }
                        }
                    }
                }
            }
        }
    }
    
}
