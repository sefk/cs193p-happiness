//
//  FaceView.m
//  happiness
//
//  Created by Sef Kloninger on 4/23/12.
//  Copyright (c) 2012 Peek 222 Software. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView


@synthesize scale = _scale;
#define DEFAULT_SCALE 0.90

- (CGFloat)scale
{
    if (!_scale) {
        _scale = DEFAULT_SCALE; // don't allow zero scale
    } 
    return _scale;
}

- (void)setScale:(CGFloat)scale
{
    if (scale != _scale) {
        _scale = scale;
        [self setNeedsDisplay]; // any time our scale changes, call for redraw
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale; // adjust our scale
        gesture.scale = 1;           // reset gestures scale to 1 (so future changes are incremental, not cumulative)
    }
}

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw; // if our bounds changes, redraw ourselves
}

- (void)awakeFromNib
{
    [self setup]; // get initialized when we come out of a storyboard
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup]; // get initialized if someone uses alloc/initWithFrame: to create us
    }
    return self;
}







- (void)drawCircleAtPoint:(CGPoint)p 
               withRadius:(CGFloat)r
                inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, r, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint midpoint;
    
    midpoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midpoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat faceSize;
    if (self.bounds.size.width < self.bounds.size.height) {
        faceSize = self.bounds.size.width / 2 * self.scale;
    } else {
        faceSize = self.bounds.size.height / 2 * self.scale;
    }
    
    CGContextSetLineWidth(context, 5);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midpoint withRadius:faceSize inContext:context];
    
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
    
    CGPoint eyePoint;
    eyePoint.x = midpoint.x - faceSize * EYE_H;
    eyePoint.y = midpoint.y - faceSize * EYE_V;
    
    [self drawCircleAtPoint:eyePoint withRadius:faceSize * EYE_RADIUS inContext:context]; // left eye
    eyePoint.x += faceSize * EYE_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:faceSize * EYE_RADIUS inContext:context]; // right eye
    
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
    
    CGPoint mouthStart;
    mouthStart.x = midpoint.x - MOUTH_H * faceSize;
    mouthStart.y = midpoint.y + MOUTH_V * faceSize;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += MOUTH_H * faceSize * 2;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * faceSize * 2/3;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * faceSize * 2/3;
    
    float smile = 1.0; // this should be delegated! it's our View's data!
    
    CGFloat smileOffset = MOUTH_SMILE * faceSize * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP2.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y); // bezier curve
    CGContextStrokePath(context);
}



@end
