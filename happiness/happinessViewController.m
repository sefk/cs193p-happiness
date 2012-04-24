//
//  happinessViewController.m
//  happiness
//
//  Created by Sef Kloninger on 4/23/12.
//  Copyright (c) 2012 Peek 222 Software. All rights reserved.
//

#import "happinessViewController.h"
#import "FaceView.h"

@interface happinessViewController()
@property (nonatomic, weak) IBOutlet FaceView * faceview;
@end

@implementation happinessViewController

@synthesize happiness = _happiness;
@synthesize faceview = _faceview;

- (void) setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceview setNeedsDisplay];
}

@end
