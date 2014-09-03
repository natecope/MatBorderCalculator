//
//  UnitSliderView.h
//  MatBorderCalculator
//
//  Created by Nathan Cope on 9/3/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitSliderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *fractionLabel;
@property (strong, nonatomic) IBOutlet UIView *view;

@end
