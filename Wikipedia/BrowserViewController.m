//
//  SecondViewController.m
//  Wikipedia
//
//  Created by Jhaybie Basco on 10/3/13.
//  Copyright (c) 2013 Greg Tropino. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *viewFullWikiButton;
- (IBAction)onViewFullWikiButtonPress:(id)sender;

@end



@implementation BrowserViewController
@synthesize passedSnippet, passedTitle, webViewOutlet;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = passedTitle;
    [webViewOutlet loadHTMLString:passedSnippet baseURL:nil];
}


- (IBAction)onViewFullWikiButtonPress:(id)sender
{
    NSString *address = @"http://en.wikipedia.org/wiki/";
    address = [address stringByAppendingString:passedTitle];
    address = [address stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webViewOutlet loadRequest:request];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
@end
