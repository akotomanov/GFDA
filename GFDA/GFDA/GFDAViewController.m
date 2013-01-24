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
    
//    self.adviceArray = [[NSArray alloc] initWithObjects:@"Do your fucking research.",
//                            @"Black is not a fucking color.",
//                            @"Be fucking authentic.",
//                            @"Work with the fucking best.",
//                            @"Don’t reinvent the fucking wheel.",
//                            @"Less is fucking more.",
//                            @"Design is fucking change.",
//                            @"Seek fucking criticism.",
//                            @"Fall in love with your fucking work.", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSString *) stringByStrippingHTML {
//    NSRange r;
//    NSString *s = [[self copy] autorelease];
//    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
//        s = [s stringByReplacingCharactersInRange:r withString:@""];
//    return s;
//}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

- (void) makeAdvice {
//    NSUInteger index = arc4random_uniform(self.adviceArray.count);
//    
//    self.adviceLabel.text = [self.adviceArray objectAtIndex:index];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://goodfuckingdesignadvice.com/refresh-advice.php"]];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSError *error=nil;
    NSDictionary *response=[NSJSONSerialization JSONObjectWithData:data options:
                            NSJSONReadingMutableContainers error:&error];
    NSString *sth=[self flattenHTML:[response objectForKey:@"new_advice"]];
    
    //NSLog(sth);
    
    self.adviceLabel.text = sth;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.adviceLabel.alpha = 1.0;
    }];
}

- (IBAction)refreshAdvice:(id)sender {
    self.adviceLabel.text = nil;
    self.adviceLabel.alpha = 0.0;
    
    [self makeAdvice];
}
@end
