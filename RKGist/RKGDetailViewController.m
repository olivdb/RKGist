//
//  RKGDetailViewController.m
//  RKGist
//
//  Created by Olivier van den Biggelaar on 11/01/14.
//  Copyright (c) 2014 Olivier van den Biggelaar. All rights reserved.
//

#import "RKGDetailViewController.h"

@interface RKGDetailViewController ()
- (void)configureView;
@end

@implementation RKGDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
