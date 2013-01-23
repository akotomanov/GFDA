//
//  GFDAViewController.m
//  GFDA
//
//  Created by Alexander Kotomanov on 24.01.13.
//  Copyright (c) 2013 Alexander Kotomanov. All rights reserved.
//

#import "GFDAViewController.h"

@interface GFDAViewController ()

@end

@implementation GFDAViewController

@synthesize adviceArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.adviceArray = [[NSArray alloc] initWithObjects:@"Do your fucking research.",
                            @"Black is not a fucking color.",
                            @"Be fucking authentic.",
                            @"Work with the fucking best.",
                            @"Don’t reinvent the fucking wheel.",
                            @"Less is fucking more.",
                            @"Design is fucking change.",
                            @"Seek fucking criticism.",
                            @"Fall in love with your fucking work.", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) makeAdvice {
    NSUInteger index = arc4random_uniform(self.adviceArray.count);
    
    self.adviceLabel.text = [self.adviceArray objectAtIndex:index];
    
    [UIView animateWithDuration:2.0 animations:^{
        self.adviceLabel.alpha = 1.0;
    }];
}

- (IBAction)refreshAdvice:(id)sender {
    self.adviceLabel.text = nil;
    self.adviceLabel.alpha = 0.0;
    
    [self makeAdvice];
}
@end
