//
//  BondController.m
//  CR_APP
//
//  Created by Itachi on 15/8/5.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "BondController.h"
#import "BondCell.h"
@interface BondController ()
{
    NSUInteger page;
}
@end

@implementation BondController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addHeaderWithTarget:self action:@selector(friendsheaderRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(friendsfooterRereshing)];
    //    [self.tableView ]
    self.searchBar.delegate = self;
    self.tableView.rowHeight = 120;
    [self friendsheaderRereshing];
    
    page = 1;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)friendsheaderRereshing
{
    [self.searchBar resignFirstResponder];
    NSDictionary *params = @{@"catalog":@"1",@"pageSize":@"10",@"showPage":@"1"};
    MKNetworkEngine *engine = enginer;
    MKNetworkOperation *op = [engine operationWithPath:transfer_url params:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        self.lists = [[NSMutableArray alloc] initWithArray:[[JSON objectForKey:@"result"] objectForKey:@"list"]];
        self.searchBar.text = @"";
        self.filterLists = self.lists;
        
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        ERROR_InterNet
        [self.tableView headerEndRefreshing];
    }];
    
    [engine enqueueOperation:op];
    
    
    
}

- (void)friendsfooterRereshing
{
    [self.searchBar resignFirstResponder];
    page ++;
    NSDictionary *params = @{@"catalog":@"1",@"pageSize":@"10",@"showPage":[NSString stringWithFormat:@"%lu",(unsigned long)page]};
    
    MKNetworkEngine *engine = enginer;
    MKNetworkOperation *op = [engine operationWithPath:transfer_url params:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSArray *list = [[JSON objectForKey:@"result"] objectForKey:@"list"];
        
        [self.lists addObjectsFromArray:list];
        self.searchBar.text = @"";
        self.filterLists = [NSMutableArray arrayWithArray:self.lists];
        
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        ERROR_InterNet
        [self.tableView footerEndRefreshing];
    }];
    
    [engine enqueueOperation:op];
    
    
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;
{
    
    if([searchText length]==0)
    {
        //查询所有
        self.filterLists = [NSMutableArray arrayWithArray:self.lists];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray ;
    
    switch (scope) {
        case 0: //
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.loanTitle contains[c] %@",searchText];
            tempArray =[self.lists filteredArrayUsingPredicate:scopePredicate];
            self.filterLists = [NSMutableArray arrayWithArray:tempArray];
            NSLog(@"%@",self.filterLists);
            break;
#warning 待更改
        case 1:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.loanTitle contains[c] %@",searchText];
            tempArray =[self.lists filteredArrayUsingPredicate:scopePredicate];
            self.filterLists = [NSMutableArray arrayWithArray:tempArray];
            
            break;
        default:
            //查询所有
            self.filterLists = [NSMutableArray arrayWithArray:self.lists];
            break;
    }
    
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"bondCell";
    BondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell.hidden) {
        cell.hidden = NO;
    }
    if (!cell)
    {
        if (ATGetDeviceWidth == 320) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentCell" owner:nil options:nil] objectAtIndex:0];
        }
        if (ATGetDeviceWidth == 375) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentCell" owner:nil options:nil] objectAtIndex:1];
        }
        if (ATGetDeviceWidth == 414) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentCell" owner:nil options:nil] objectAtIndex:2];
        }
        
    }
    
    NSDictionary *item = [self.filterLists objectAtIndex:indexPath.row];
    
//    cell.itemTitle.text = [item valueForKey:@"loanTitle"];
//    cell.itemEndTime.text = [[item valueForKey:@"loanExpireTime"] substringToIndex:10];
//    cell.itemMoney.text = [[item valueForKey:@"loanMoney"] stringValue];
//    cell.itemRate.text = [[[item valueForKey:@"loanRate"] stringValue] stringByAppendingString:@"%"];
//    NSArray *types = @[@"信用贷",@"抵押贷",@"担保贷",@"综合贷"];
//    int type = [[item valueForKey:@"loanType"] intValue];
//    
//    cell.type = types[type-1];
//    
//    NSString *progressValue = [[item valueForKey:@"loanProgress"] stringValue];
//    cell.progressView.progressCounter = (float)[progressValue floatValue]/25;
    
    
    return cell;
    
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchBar resignFirstResponder];
}


#pragma mark - UISearchBar Delegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //查询所有
    
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
    [self filterContentForSearchText:@"" scope:-1];
    
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:1.5f animations:^{
        
        searchBar.showsCancelButton = YES;
    }];
    
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self filterContentForSearchText:searchText scope:searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
