//
//  ViewController.m
//  Wikipedia
//
//  Created by Jhaybie Basco on 10/3/13.
//  Copyright (c) 2013 Greg Tropino. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()
{
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    __weak IBOutlet UILabel *loadingLabel;
    __weak IBOutlet UIButton *searchButton;
    NSMutableDictionary *searchResultDictionary;
}
@end


@implementation RootViewController
@synthesize searchResultTableView, searchTextField;



#pragma mark UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView2 dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", searchResultDictionary.allKeys[indexPath.row]];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResultDictionary count];
}


#pragma mark UIStoryBoardSegueDelegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    NSIndexPath *indexPath = [self.searchResultTableView indexPathForCell:sender];
    
    BrowserViewController *bvc = segue.destinationViewController;
    
    NSString *tempKey = [NSString stringWithFormat:@"%@", searchResultDictionary.allKeys[indexPath.row]];
    NSString *tempSnippet = [NSString stringWithFormat:@"%@", [searchResultDictionary objectForKey:tempKey]];
    
    bvc.passedTitle = [NSString stringWithFormat:@"%@", tempKey];
    bvc.passedSnippet = [NSString stringWithFormat:@"%@", tempSnippet];
}




- (void)checkTextField:(NSTimer *)timer
{
    if ([searchTextField.text isEqual:@""])
    {
        [searchButton setEnabled:NO];
        [searchResultTableView setHidden:YES];
    }
    else
        [searchButton setEnabled:YES];
}


- (void) performSearch
{
    NSString *address = @"https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=";
    address = [address stringByAppendingString:searchTextField.text];
    address = [address stringByAppendingString:@"&srprop=snippet&format=json"];
    address = [address stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [searchTextField setHidden:YES];
    [searchButton setHidden:YES];
    [loadingLabel setHidden:NO];
    [activityIndicator setHidden:NO];
    [activityIndicator startAnimating];
    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [searchTextField setHidden:NO];
         [searchButton setHidden:NO];
         [loadingLabel setHidden:YES];
         [activityIndicator setHidden:YES];
         [activityIndicator stopAnimating];
         searchResultDictionary = [[NSMutableDictionary alloc] init];
         [searchResultTableView setHidden: NO];
         if (!connectionError)
         {
             NSMutableDictionary *initialDump, *secondaryDump;
             NSArray *tempArray;
             initialDump = [NSJSONSerialization JSONObjectWithData:data options:0 error:&connectionError];
             secondaryDump = [initialDump objectForKey:@"query"];
             tempArray = [secondaryDump objectForKey:@"search"];
             for (int i = 0; i < [tempArray count]; i++)
             {
                 secondaryDump = tempArray[i];
                 NSString *title = [secondaryDump objectForKey:@"title"];
                 NSString *snippet = [secondaryDump objectForKey:@"snippet"];
                 [searchResultDictionary setObject:snippet forKey:title];
             }
         }
         else
         {
             [searchResultDictionary setObject:@"" forKey:@"Error encountered"];
         }
         [searchResultTableView reloadData];
     }];
}


- (IBAction)pressedSearchButton:(id)sender
{
    [self.view endEditing:YES];
    [self performSearch];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [activityIndicator setHidden:YES];
    [searchResultTableView setHidden:YES];
    [searchTextField becomeFirstResponder];
    __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                               target:self
                                                             selector:@selector(checkTextField:)
                                                             userInfo:nil
                                                              repeats:YES];
}


@end
