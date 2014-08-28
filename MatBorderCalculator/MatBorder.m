//
//  MatBorder.m
//  MatBorderCalculator
//
//  Created by Nathan Cope on 7/16/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import "MatBorder.h"

static NSString *const kFrameWidth = @"frameWidth";
static NSString *const kFrameHeight = @"frameHeight";
static NSString *const kImageWidth = @"imageWidth";
static NSString *const kImageHeight = @"imageHeight";

@implementation MatBorder

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _frameWidth = [aDecoder decodeDoubleForKey:kFrameWidth];
        _frameHeight = [aDecoder decodeDoubleForKey:kFrameHeight];
        _imageWidth = [aDecoder decodeDoubleForKey:kImageWidth];
        _imageHeight = [aDecoder decodeDoubleForKey:kImageHeight];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeDouble:_frameWidth forKey:kFrameWidth];
    [aCoder encodeDouble:_frameHeight forKey:kFrameHeight];
    [aCoder encodeDouble:_imageWidth forKey:kImageWidth];
    [aCoder encodeDouble:_imageHeight forKey:kImageHeight];
    
}

- (void)calculateBorders{
    
    NSLog(@"Calculate Borders!");
    
    double horizontalBorder = (self.frameWidth - self.imageWidth) / 2.0;
    double verticalBorder = (self.frameHeight - self.imageHeight) / 2.0;
    
    self.leftBorderWidth = horizontalBorder;
    self.rightBorderWidth = horizontalBorder;
    self.topBorderWidth = verticalBorder;
    self.bottomBorderWidth = verticalBorder;
    
}

- (NSString *)description {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setMaximumFractionDigits:2];
    
    return [NSString stringWithFormat:@"Frame: %@ x %@ Image: %@ x %@",
            [numberFormatter stringFromNumber:@(self.frameWidth)],
            [numberFormatter stringFromNumber:@(self.frameHeight)],
            [numberFormatter stringFromNumber:@(self.imageWidth)],
            [numberFormatter stringFromNumber:@(self.imageHeight)]];
    
    //return [NSString stringWithFormat:@"Frame: %0.0fx%0.0f Image: %0.0fx%0.0f", self.frameWidth, self.frameHeight, self.imageWidth, self.imageHeight];
}

@end
