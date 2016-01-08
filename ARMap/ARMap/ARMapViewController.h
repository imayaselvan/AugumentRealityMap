//
//  ViewController.h
//  ARMap
//
//  Created by imayaselvan on 1/6/16.
//  Copyright © 2016 imayaselvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRARManager.h"
#import <GoogleMaps/GoogleMaps.h>
#define METERS_PER_MILE 1609.344
#define ZOOM_LEVEL      16

@interface ARMapViewController : UIViewController

@property(nonatomic, strong)PRARManager *aRManager;
@end

