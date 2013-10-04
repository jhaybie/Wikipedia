//
//  ViewController.h
//  Wikipedia
//
//  Created by Jhaybie Basco on 10/3/13.
//  Copyright (c) 2013 Greg Tropino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowserViewController.h"

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;

- (IBAction)pressedSearchButton:(id)sender;


@end
