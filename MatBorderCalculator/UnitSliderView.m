//
//  UnitSliderView.m
//  MatBorderCalculator
//
//  Created by Nathan Cope on 9/3/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import "UnitSliderView.h"

@implementation UnitSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        
        //Load xib
        
        [[NSBundle mainBundle]loadNibNamed:@"UnitSliderView" owner:self options:nil];
        
        //setup subview
        
        [self addSubview:self.view];
        
    }
    return self;
}

@end
