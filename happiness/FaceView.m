//
//  FaceView.m
//  happiness
//
//  Created by Sef Kloninger on 4/23/12.
//  Copyright (c) 2012 Peek 222 Software. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

#define FACE_SIZE_RELATIVE_TO_REGION 0.90

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint midpoint;
    
    midpoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midpoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat facesize;
    if (self.bounds.size.width < self.bounds.size.height) {
        facesize = self.bounds.size.width / 2 * FACE_SIZE_RELATIVE_TO_REGION;
    } else {
        facesize = self.bounds.size.height / 2 * FACE_SIZE_RELATIVE_TO_REGION;
    }
    
    CGContextSetLineWidth(context, 5);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midpoint withRadius:facesize inContext:context];
    
}

@end
