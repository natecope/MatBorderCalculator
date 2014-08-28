//
//  LayoutTableViewController.h
//  MatBorderCalculator
//
//  Created by Nathan Cope on 8/17/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import <UIKit/UIKit.h>

//forward declaration
@class LayoutTableViewController;

@protocol LayoutTableViewControllerDelegate <NSObject>

- (void)layoutTableViewControllerDidFinish:(LayoutTableViewController *)layoutTableViewController;
- (void)layoutTableViewController:(LayoutTableViewController *)layoutTableViewController didSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface LayoutTableViewController : UITableViewController

@property (nonatomic, weak) NSMutableArray *matBorderLayoutArray;
@property (nonatomic, weak) id<LayoutTableViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedRow;

@end
