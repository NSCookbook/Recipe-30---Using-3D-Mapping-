//
//  ViewController.m
//  Recipe 30 Using 3D maps
//
//  Created by joseph hoffman on 10/21/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <UITextFieldDelegate,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *latTextField;
@property (weak, nonatomic) IBOutlet UITextField *longTextField;
@property (strong, nonatomic) NSString *startLat;
@property (strong, nonatomic) NSString *startLong;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.latTextField.delegate = self;
    self.longTextField.delegate = self;
    
    self.mapView.delegate = self;

    //Set a few MKMapView Properties to allow pitch, building view, points of interest, and zooming.
    self.mapView.pitchEnabled = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.zoomEnabled = YES;
    
    
    //set up initial location
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(40.6892, -74.0444);
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(40.6892, -74.0442);
    MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground
                                                        fromEyeCoordinate:eye
                                                              eyeAltitude:50];
    
    self.mapView.camera = mapCamera;

    
}

- (IBAction)setStartingPoint:(id)sender
{
    self.startLat = self.latTextField.text;
    self.startLong = self.longTextField.text;
    
    double startLatFloat = [self.startLat doubleValue];
    double startLongFloat = [self.startLong doubleValue];
    
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(startLatFloat, startLongFloat);
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(startLatFloat, startLongFloat+.0020);
    MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground
                                                        fromEyeCoordinate:eye
                                                              eyeAltitude:200];
    
    self.mapView.camera = mapCamera;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeMapLocation:(id)sender
{
    
    

    
    double latFloat = [self.latTextField.text doubleValue];
    double longFloat = [self.longTextField.text doubleValue];
  
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(latFloat, longFloat);
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(latFloat, longFloat+.0020);
    MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground
                                                        fromEyeCoordinate:eye
                                                              eyeAltitude:700];
    
    [UIView animateWithDuration:25.0 animations:^{
        
        
        
        self.mapView.camera = mapCamera;
        
    }];
    

    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    NSLog(@"pitch: %f",self.mapView.camera.pitch);
    NSLog(@"altitude: %f",self.mapView.camera.altitude);
    NSLog(@"heading: %f",self.mapView.camera.heading);

    
    
    
}

@end
