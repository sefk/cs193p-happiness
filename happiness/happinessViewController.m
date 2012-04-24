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
@property (nonatomic, weak) IBOutlet FaceView * faceView;
@end

@implementation happinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (void) setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    // enable pinch gestures in the FaceView using its pinch: handler
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all orientations
}



@end
