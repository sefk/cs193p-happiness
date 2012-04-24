//
//  FaceView.h
//  happiness
//
//  Created by Sef Kloninger on 4/23/12.
//  Copyright (c) 2012 Peek 222 Software. All rights reserved.
//

@class FaceView;

#import <UIKit/UIKit.h>

@protocol FaceViewDataSource

- (float) smileForFaceView:(FaceView *)sender;
- (void)  smile:(float)newSmile forFaceView:(FaceView *)sender;

@end

@interface FaceView : UIView

@property (nonatomic) CGFloat scale;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;


@end
