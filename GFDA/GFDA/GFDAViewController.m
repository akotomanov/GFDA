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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://goodfuckingdesignadvice.com/refresh-advice.php"]];
        
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSError *error=nil;
        NSDictionary *response=[NSJSONSerialization JSONObjectWithData:data options:
                                       NSJSONReadingMutableContainers error:&error];
        NSString* sth=[self flattenHTML:[response objectForKey:@"new_advice"]];
        
        __weak typeof (self) bself = self;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
                bself.adviceLabel.alpha = 0.0;
                
                } completion:^(BOOL finished){
                    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                        bself.adviceLabel.text = sth;
                        bself.adviceLabel.alpha = 1.0;
                        
                        } completion:nil];
                    }];
            
            });
        
        });
}

- (IBAction)refreshAdvice:(id)sender {
    [self makeAdvice];
}
@end
