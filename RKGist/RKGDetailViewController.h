//
//  RKGDetailViewController.h
//  RKGist
//
//  Created by Olivier van den Biggelaar on 11/01/14.
//  Copyright (c) 2014 Olivier van den Biggelaar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKGDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
