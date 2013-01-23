//
//  GFDAViewController.h
//  GFDA
//
//  Created by Alexander Kotomanov on 24.01.13.
//  Copyright (c) 2013 Alexander Kotomanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFDAViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *adviceLabel;

- (IBAction)refreshAdvice:(id)sender;


@end
