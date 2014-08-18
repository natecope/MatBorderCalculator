//
//  LayoutTableViewController.m
//  MatBorderCalculator
//
//  Created by Nathan Cope on 8/17/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import "LayoutTableViewController.h"
#import "MatBorder.h"

@interface LayoutTableViewController ()

@end

@implementation LayoutTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}
- (IBAction)doneButtonPressed:(id)sender {
    
    [self.delegate layoutTableViewControllerDidFinish:self];
    
}

- (IBAction)editButtonPressed:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [_matBorderLayoutArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    MatBorder *matBorder = _matBorderLayoutArray[indexPath.row];
    
    cell.textLabel.text = matBorder.description;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.delegate layoutTableViewController:self didSelectIndexPath:indexPath];
    
}



@end
