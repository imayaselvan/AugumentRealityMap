//
//  ViewController.m
//  ARMap
//
//  Created by imayaselvan on 1/6/16.
//  Copyright © 2016 imayaselvan. All rights reserved.
//

#import "ARMapViewController.h"
#import "eCDataCenter.h"
@interface ARMapViewController ()<CLLocationManagerDelegate>{
    GMSMapView *MapView;

}
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation* currentLocation;
@property (nonatomic, strong) UIView *sourceView;

@end

@implementation ARMapViewController
@synthesize aRManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aRManager = [[PRARManager alloc]init];
    [self invokeGPS];
    self.sourceView = [[UIView alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, self.view.frame.size.height - 100)];
    self.sourceView.layer.shadowColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    [self.sourceView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.sourceView];
    
}
-(void)invokeGPS {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getMycurrentLocation];
}
-(void)getMycurrentLocation{
    
    if (![self isAuthorized]) {
        [self requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    
}
- (BOOL)isAuthorized{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if(status == kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}
- (void)requestWhenInUseAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    [self.locationManager requestWhenInUseAuthorization];

    if (status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"The  App would like to use your current location.";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark - CLLocationManagerDelegate

    
    


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    [self showMapWithLocation:newLocation];
    // Stop Location Manager
    [self.locationManager stopUpdatingLocation];
    
}
-(void)showMapWithLocation :(CLLocation *)location{
    
    /*
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:ZOOM_LEVEL];
    MapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    GMSMarker *marker = [GMSMarker markerWithPosition:location.coordinate];
    marker.draggable =YES;
    marker.map = MapView;
    
     [[GMSGeocoder geocoder] reverseGeocodeCoordinate:location.coordinate completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
     NSLog(@"reverse geocoding results:");
     for(GMSAddress* addressObj in [response results])
     {
     marker.title =addressObj.locality;
     marker.snippet =addressObj.subLocality;
     }
     }];
    
        //   [shopMap animateToLocation:location.coordinate];
    
    [self.sourceView reloadInputViews];
    MapView.frame = self.sourceView.frame;
    self.view = MapView;
   // self.sourceView = MapView;
*/
    
//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=cruise&key=YOUR_API_KEY
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=33.8670522,151.1957362&radius=500&types=food&name=cruise&key=AIzaSyBCpg0-a6jVgRLsdEc4TIkWhoG8UlVmYnM"];
    
    [[eCDataCenter sharedCenter]getResponseWithUrlEndPoint:urlString urlParameters:nil requestType:GetRequestType successBlock:^(id response) {
        
        NSLog(@"%@",response);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


- (IBAction)menuChanged:(id)sender{
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 1) {
        //MapView
        [self getMycurrentLocation];

    }
    else{
        //Augumneted Reality
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
