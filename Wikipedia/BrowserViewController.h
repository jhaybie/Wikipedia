//
//  SecondViewController.h
//  Wikipedia
//
//  Created by Jhaybie Basco on 10/3/13.
//  Copyright (c) 2013 Greg Tropino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webViewOutlet;
@property (weak, nonatomic) NSString *passedTitle;
@property (weak, nonatomic) NSString *passedSnippet;
@end
