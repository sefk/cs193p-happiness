//
//  happinessViewController.m
//  happiness
//
//  Created by Sef Kloninger on 4/23/12.
//  Copyright (c) 2012 Peek 222 Software. All rights reserved.
//

#import "happinessViewController.h"
#import "FaceView.h"

@interface happinessViewController() <FaceViewDataSource>
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
    self.faceView.dataSource = self;

    // enable pinch gestures in the FaceView using its pinch: handler
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappynessChange:)]];
}


- (void)handleHappynessChange:(UIPanGestureRecognizer *)gesture 
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        
        CGPoint translationAmount = [gesture translationInView:self.faceView];
        self.happiness += translationAmount.y / 2;
        if (self.happiness < 0) self.happiness = 0;
        if (self.happiness > 100) self.happiness = 100;
        
        [gesture setTranslation:CGPointZero inView:self.faceView];
        
    }
}



- (float) smileForFaceView:(FaceView *)sender
{
    // happiness is 0-100.  smile range is -1 to 1.
    return (self.happiness - 50) / (float)50;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all orientations
}


@end
