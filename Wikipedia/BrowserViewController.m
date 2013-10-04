//
//  SecondViewController.m
//  Wikipedia
//
//  Created by Jhaybie Basco on 10/3/13.
//  Copyright (c) 2013 Greg Tropino. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end


@implementation BrowserViewController
@synthesize passedSnippet, passedTitle, webViewOutlet;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = passedTitle;
    [webViewOutlet loadHTMLString:passedSnippet baseURL:nil];
    
}


@end
