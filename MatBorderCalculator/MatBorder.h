//
//  MatBorder.h
//  MatBorderCalculator
//
//  Created by Nathan Cope on 7/16/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatBorder : NSObject <NSCoding>

@property (assign, nonatomic) double frameWidth;
@property (assign, nonatomic) double frameHeight;
@property (assign, nonatomic) double imageWidth;
@property (assign, nonatomic) double imageHeight;

@property (assign, nonatomic) double leftBorderWidth;
@property (assign, nonatomic) double rightBorderWidth;
@property (assign, nonatomic) double topBorderWidth;
@property (assign, nonatomic) double bottomBorderWidth;

- (id)initWithFrameWidth:(double)frameWidth
             frameHeight:(double)frameHeight
              imageWidth:(double)imageWidth
             imageHeight:(double)imageHeight;

- (void)calculateBorders;
@end
