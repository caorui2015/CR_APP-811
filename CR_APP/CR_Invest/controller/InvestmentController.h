//
//  InvestmentController.h
//  CR_APP
//
//  Created by Itachi on 15/8/5.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestmentController : UITableViewController<UISearchBarDelegate,UISearchControllerDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) NSMutableArray *lists;
@property (strong, nonatomic) NSMutableArray *filterLists;


- (void)friendsheaderRereshing;
@end
