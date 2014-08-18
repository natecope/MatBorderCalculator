//
//  ViewController.m
//  MatBorderCalculator
//
//  Created by Nathan Cope on 7/16/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import "ViewController.h"
#import "MatBorder.h"
#import "LayoutTableViewController.h"

@interface ViewController () <UITextFieldDelegate, LayoutTableViewControllerDelegate>{
    
    MatBorder *_matBorder;
    NSMutableArray *_matBorderLayoutArray;
    NSInteger _selectedRow;
    
}
@property (weak, nonatomic) IBOutlet UITextField *frameWidthTextField;
@property (weak, nonatomic) IBOutlet UITextField *frameHeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageWidthTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageHeightTextField;

@property (weak, nonatomic) IBOutlet UILabel *topBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBorderLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frameWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frameHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // This says this object wants to be sent messages from UITextFieldDelegate
    self.frameWidthTextField.delegate = self;
    self.frameHeightTextField.delegate = self;
    self.imageWidthTextField.delegate = self;
    self.imageHeightTextField.delegate = self;
    
    _matBorderLayoutArray = [[NSMutableArray alloc]init];
    
    [self addTestData];
    
    _selectedRow = 0;
    
    //NSLog(@"%@", _matBorderLayoutArray);
    
}

- (void)addTestData{
    for(int i=0; i<5; i++){
        MatBorder *matBorder = [[MatBorder alloc]init];
        matBorder.frameWidth = 10 + arc4random_uniform(10);
        matBorder.frameHeight = 8 + arc4random_uniform(8);
        matBorder.imageWidth = 7 + arc4random_uniform(7);
        matBorder.imageHeight = 5 + arc4random_uniform(5);
        
        [_matBorderLayoutArray addObject:matBorder];
    }
}

- (void)dealloc{
    
    // Very important when freeing memory. If the messenger sends a message to this delegate
    // and the object is freed, app will crash
    
    self.frameWidthTextField.delegate = nil;
    self.frameHeightTextField.delegate = nil;
    self.imageWidthTextField.delegate = nil;
    self.imageHeightTextField.delegate = nil;
}


//manual way of presenting a view that's in another controller

- (IBAction)layoutsButtonPressed:(id)sender {
    
    //get the current storyboard (what do we do for ipad?)
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
   
    //instantiate the new controller we want
    LayoutTableViewController *layoutTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"LayoutTableViewController"];

    //delegate
    layoutTableViewController.delegate = self;
    
    //instantiate its host nav controller
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:layoutTableViewController];
    
    //assign data
    layoutTableViewController.matBorderLayoutArray = _matBorderLayoutArray;
    
    //present
    [self presentViewController:navigationController animated:YES completion:nil];
    
    
}

- (IBAction)calculateButtonPressed:(id)sender {
    NSLog(@"Calculate!");
    
    [self calculate];
    [self hideKeyboard];
    
    [self.view setNeedsUpdateConstraints];
    
}

- (void)calculate {
    
    if(!_matBorder){
        _matBorder = [[MatBorder alloc]init];
    }
    
    //'text' is an NSString object. doubleValue is a function of NSString, so we can call it.
    _matBorder.frameWidth = [self.frameWidthTextField.text doubleValue];
    _matBorder.frameHeight = [self.frameHeightTextField.text doubleValue];
    _matBorder.imageWidth = [self.imageWidthTextField.text doubleValue];
    _matBorder.imageHeight = [self.imageHeightTextField.text doubleValue];
    
    [_matBorder calculateBorders];
    
    // Display the calculations
    
    self.topBorderLabel.text = [@(_matBorder.topBorderWidth) stringValue];
    self.bottomBorderLabel.text = [@(_matBorder.bottomBorderWidth) stringValue];
    self.leftBorderLabel.text = [@(_matBorder.leftBorderWidth) stringValue];
    self.rightBorderLabel.text = [@(_matBorder.rightBorderWidth) stringValue];
    
    
    
}

- (void)updateViewConstraints {
    
    double maxEdgeLength = 180;
    double frameWidth = _matBorder.frameWidth;
    double frameHeight = _matBorder.frameHeight;
    double framePixelWidth = 0;
    double framePixelHeight = 0;
    
    if(frameWidth > 0 && frameHeight > 0){
        
        if(frameWidth >= frameHeight){
            framePixelWidth = maxEdgeLength;
            framePixelHeight = framePixelWidth * (frameHeight / frameWidth);
        } else {
            framePixelHeight = maxEdgeLength;
            framePixelWidth = framePixelHeight * (frameWidth / frameHeight);
        }
        
        self.frameWidthConstraint.constant = framePixelWidth;
        self.frameHeightConstraint.constant = framePixelHeight;
        
        double imageWidth = _matBorder.imageWidth;
        double imageHeight = _matBorder.imageHeight;
        
        double pixelsPerInch = framePixelWidth / frameWidth;
        
        self.imageWidthConstraint.constant = imageWidth * pixelsPerInch;
        self.imageHeightConstraint.constant = imageHeight * pixelsPerInch;
        
    }
    
    [super updateViewConstraints];
    
    
}

- (void)hideKeyboard {
    
    //[self.frameWidthTextField resignFirstResponder];
    [self.view endEditing:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self calculateButtonPressed:nil];
    
    return YES;
    
}

- (void) updateDisplayForSelectedRow{
    
    
    if(_selectedRow < [_matBorderLayoutArray count]){
        MatBorder *matBorder = _matBorderLayoutArray[_selectedRow];
    
        // Update the UI for new setting
        
        _frameWidthTextField.text = [@(matBorder.frameWidth) stringValue];
        _frameHeightTextField.text = [@(matBorder.frameHeight) stringValue];
        
        _imageWidthTextField.text = [@(matBorder.imageWidth) stringValue];
        _imageHeightTextField.text = [@(matBorder.imageHeight) stringValue];
    }
}



#pragma mark - LayoutTableViewControllerDelegate Methods

- (void)layoutTableViewController:(LayoutTableViewController *)layoutTableViewController didSelectIndexPath:(NSIndexPath *)indexPath{

    _selectedRow = indexPath.row;
    
    [self updateDisplayForSelectedRow];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)layoutTableViewControllerDidFinish:(LayoutTableViewController *)layoutTableViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
