//
//  VisitDetailViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocationKit/LocationKit.h>
#import <MapKit/MapKit.h>

@interface VisitDetailViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) LKVisit *visit;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *localityLabel;

@end
