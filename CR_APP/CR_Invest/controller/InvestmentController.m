//
//  InvestmentController.m
//  CR_APP
//
//  Created by Itachi on 15/8/5.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "InvestmentController.h"
#import "InvestmentCell.h"

@interface InvestmentController ()
{
    NSUInteger page;//加载第几页数据
    NSMutableData *datas;
}
@end

@implementation InvestmentController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    [self.tableView addHeaderWithTarget:self action:@selector(friendsheaderRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(friendsfooterRereshing)];
    
    self.tableView.rowHeight = 120;
    [self friendsheaderRereshing];
    
    page = 1;
    
    
}

//下拉刷新
- (void)friendsheaderRereshing
{
    [self.searchBar resignFirstResponder];
    NSDictionary *params = @{@"catalog":@"1",@"pageSize":@"10",@"showPage":@"1"};
    MKNetworkEngine *engine = enginer;
    MKNetworkOperation *op = [engine operationWithPath:inverst_url params:params];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"error = %@\n localizedRecoverySuggestion = %@",[error localizedDescription],[error localizedRecoverySuggestion]);
        NSLog(@"nihao");
       
        self.lists = [[NSMutableArray alloc] initWithArray:[[JSON objectForKey:@"result"] objectForKey:@"list"]];
        self.searchBar.text = @"";
        self.filterLists = self.lists;
        
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        ERROR_InterNet
        NSLog(@"1");
        [self.tableView headerEndRefreshing];
    }];
    
    [engine enqueueOperation:op];
    
    
    
  
    
#warning 可以解密
//    NSURL *URL = [NSURL URLWithString:@"http://36.33.24.175:6019/mobileIos/loanRequest.json"];
//    NSString *post = [NSString stringWithFormat:@"catalog=%@&pageSize=%@&showPage=%@", @"6J6LWi3V2W6zfWtxW8HVtA==",@"oxPbkX38xODrgnZhZ5Y71Q==",@"6J6LWi3V2W6zfWtxW8HVtA=="];
//    
//    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:postData];
//
//    NSURLConnection *connection = [[NSURLConnection alloc]
//                                   initWithRequest:request delegate:self];
//    
//    if (connection) {
//        datas = [NSMutableData new];
//    }
//    
}



//#pragma mark- NSURLConnection 回调方法
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [datas appendData:data];
//}
//
//
//-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
//    
//    NSLog(@"%@",[error localizedDescription]);
//}
//
//- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
//    NSLog(@"请求完成...");
//    NSLog(@"%@",datas);
////    NSString *encryptString = [datas base64EncodedString];
//    
//    NSString *string = [[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",[NSData AES256DecryptWithCiphertext:string]);
//    
//    
//    
////    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[NSData AES256DecryptWithCiphertext:datas] options:NSJSONReadingAllowFragments error:nil];
////    NSLog(@"dic = %@",dict);
//    
//}








//上拉刷新
- (void)friendsfooterRereshing
{
    [self.searchBar resignFirstResponder];
    page ++;
    NSDictionary *params = @{@"catalog":@"1",@"pageSize":@"10",@"showPage":[NSString stringWithFormat:@"%lu",(unsigned long)page]};
    
    MKNetworkEngine *engine = enginer;
    MKNetworkOperation *op = [engine operationWithPath:inverst_url params:params];
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





#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"investmentCell";
    InvestmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    
    cell.itemTitle.text = [item valueForKey:@"loanTitle"];
    cell.itemEndTime.text = [[item valueForKey:@"loanExpireTime"] substringToIndex:10];
    cell.itemMoney.text = [[item valueForKey:@"loanMoney"] stringValue];
    cell.itemRate.text = [[[item valueForKey:@"loanRate"] stringValue] stringByAppendingString:@"%"];
    NSArray *types = @[@"信用贷",@"抵押贷",@"担保贷",@"综合贷"];
    int type = [[item valueForKey:@"loanType"] intValue];
    
    cell.type = types[type-1];
    
    NSString *progressValue = [[item valueForKey:@"loanProgress"] stringValue];
    cell.progressView.progressCounter = (float)[progressValue floatValue]/25;
    
    
    return cell;
    
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchBar resignFirstResponder];
}


#pragma mark - UISearchBar Delegate
#pragma mark - 搜索
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
