//
//  CommunityViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "CommunityViewController.h"
#import "communityOneTableViewCell.h"
#import "communityModel.h"
#import "CommunityDetailViewController.h"
@interface CommunityViewController ()<UIScrollViewDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)UISegmentedControl *segment;
@property (nonatomic , strong)UIScrollView *scr;
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic , strong)UITableView *table1;
@property (nonatomic , strong)UITableView *table2;
@property (nonatomic , strong)NSMutableArray *arr2;
@property (nonatomic , strong)UIButton *messageBtn;
@property (nonatomic , strong)UIButton *groupBtn;
@property (nonatomic , strong)UIButton *personBtn;
@property (nonatomic , assign)NSInteger limit;
@property (nonatomic , assign)NSInteger start;
@property (nonatomic , assign)NSInteger isNewChose;
@property (nonatomic , assign)NSInteger isHotChose;
@property (nonatomic , strong)NSMutableDictionary *dic;

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSegmentView];
    [self creatScrollView];
    [self creatTableView1];
    [self cteatTableView2];
    [self creatTopView];
    
    self.arr = [NSMutableArray array];
    self.arr2 = [NSMutableArray array];
    
    self.isNewChose = 1;
    self.isHotChose = 1;
    self.limit = 10;
    self.start = 0;
    self.dic =[@{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"client":@"1",@"sort":@"addtime",@"limit":[NSString stringWithFormat:@"%ld",(long)self.limit],@"version":@"3.0.2",@"start":[NSString stringWithFormat:@"%ld",(long)self.start],@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0"}mutableCopy];
    [self requset:self.dic];
    
    [self reloadView1];
    [self reloadView2];
    
    // Do any additional setup after loading the view.
}

-(void)requset:(NSDictionary *)dic
{
    [RequestManager requestWithUrlString:KCommunityURL parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dic1);
        NSDictionary *dataDic = dic1[@"data"];
        NSString *s = [NSString stringWithFormat:@"%@",dataDic[@"total"]];
        if ([s isEqualToString:@"0"]) {
            NSLog(@"==============================没有更多数据");
            [self.table1.mj_footer endRefreshing];
            [self.table2.mj_footer endRefreshing];
            return ;
        }
        if (self.start == 0) {
            if (self.segment.selectedSegmentIndex == 0) {
                [self.arr removeAllObjects];
            }else if (self.segment.selectedSegmentIndex == 1){
                [self.arr2 removeAllObjects];
            }
        }
        if (self.segment.selectedSegmentIndex == 0) {
            NSMutableArray *arr1 = [communityModel arr:dic1];
            for (communityModel *model in arr1) {
                [self.arr addObject:model];
            }
        }else{
            NSMutableArray *arr2 = [communityModel arr:dic1];
            for (communityModel *model in arr2) {
                [self.arr2 addObject:model];
            }
        }
        [self.table1 reloadData];
        [self.table2 reloadData];
        [self.table1.mj_footer endRefreshing];
        [self.table1.mj_header endRefreshing];
        [self.table2.mj_footer endRefreshing];
        [self.table2.mj_header endRefreshing];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



-(void)creatTopView
{
    self.messageBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.messageBtn.frame = CGRectMake(kScreenWidth/2-20, 30, 20, 20);
    [self.messageBtn setImage:[UIImage imageNamed:@"comments_filled"] forState:(UIControlStateNormal)];
    [self.messageBtn addTarget:self action:@selector(messageAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.groupBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.groupBtn.frame = CGRectMake(kScreenWidth/2+40, 30, 20, 20);
    [self.groupBtn addTarget:self action:@selector(groupAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.groupBtn setImage:[UIImage imageNamed:@"group"] forState:(UIControlStateNormal)];
    self.personBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.personBtn addTarget:self action:@selector(personAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.personBtn.frame = CGRectMake(kScreenWidth/2+100, 30, 20, 20);
    [self.personBtn setImage:[UIImage imageNamed:@"user"] forState:(UIControlStateNormal)];
    self.groupBtn.tintColor = [UIColor grayColor];
    self.personBtn.tintColor = [UIColor grayColor];
    self.messageBtn.tintColor = [UIColor blackColor];
    [self.view addSubview:self.messageBtn];
    [self.view addSubview:self.groupBtn];
    [self.view addSubview:self.personBtn];
}

-(void)messageAction
{
    self.groupBtn.tintColor = [UIColor grayColor];
    self.personBtn.tintColor = [UIColor grayColor];
    self.messageBtn.tintColor = [UIColor blackColor];
}

-(void)groupAction
{
    self.groupBtn.tintColor = [UIColor blackColor];
    self.personBtn.tintColor = [UIColor grayColor];
    self.messageBtn.tintColor = [UIColor grayColor];
    
}

-(void)personAction
{
    self.groupBtn.tintColor = [UIColor grayColor];
    self.personBtn.tintColor = [UIColor blackColor];
    self.messageBtn.tintColor = [UIColor grayColor];
    
}


-(void)creatSegmentView
{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"Hot",@"New"]];
    self.segment.frame = CGRectMake(0, 0, 150, 30);
    self.segment.center = CGPointMake(kScreenWidth/2, 80);
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor blackColor];
    [self.segment addTarget:self action:@selector(choseAction) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.segment];
}

-(void)choseAction
{
    self.scr.contentOffset = CGPointMake(self.segment.selectedSegmentIndex * kScreenWidth, 0);
    if (self.segment.selectedSegmentIndex == 0) {
        
        self.limit = self.isNewChose * 10;
        self.start = 0;
        self.dic[@"sort"] = @"addtime";
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        [self requset:self.dic];
    }else if (self.segment.selectedSegmentIndex == 1){
        self.limit = self.isHotChose * 10;
        self.start = 0;
        self.dic[@"sort"] = @"hot";
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        [self requset:self.dic];

    }
    
    
    [self.table1 reloadData];
    [self.table2 reloadData];
    
}
//


-(void)creatScrollView
{
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110, kScreenWidth, kScreenHeight - 110)];
    self.scr.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    self.scr.contentOffset = CGPointMake(0, 0);
    self.scr.delegate = self;
    self.scr.bounces = NO;
    self.scr.pagingEnabled = YES;
    self.scr.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scr];
}


-(void)reloadView1
{
    self.table1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.start = 0;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        if (self.segment.selectedSegmentIndex == 0) {
            self.limit = self.isNewChose * 10;
            self.dic[@"sort"] = @"addtime";
        }else if (self.segment.selectedSegmentIndex == 1){
            
            self.limit = self.isHotChose * 10;
            self.dic[@"sort"] = @"hot";
        }
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        [self requset:self.dic];
    }];
    
    self.table1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.start = self.isNewChose * 10;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        self.dic[@"limit"] = @"10";
        if (self.segment.selectedSegmentIndex == 0) {
            self.dic[@"sort"] = @"addtime";
            self.isNewChose += 1;
        }else if (self.segment.selectedSegmentIndex == 1){
            self.dic[@"sort"] = @"hot";
            self.isHotChose += 1;
        }
        [self requset:self.dic];
    }];
    
}

-(void)reloadView2
{
    self.table2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.start = 0;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        if (self.segment.selectedSegmentIndex == 0) {
            self.limit = self.isNewChose * 10;
            self.dic[@"sort"] = @"addtime";
        }else if (self.segment.selectedSegmentIndex == 1){
            
            self.limit = self.isHotChose * 10;
            self.dic[@"sort"] = @"hot";
        }
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        [self requset:self.dic];
    }];
    
    self.table2.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.start = self.isNewChose * 10;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        self.dic[@"limit"] = @"10";
        if (self.segment.selectedSegmentIndex == 0) {
            self.dic[@"sort"] = @"addtime";
            self.isNewChose += 1;
        }else if (self.segment.selectedSegmentIndex == 1){
            self.dic[@"sort"] = @"hot";
            self.isHotChose += 1;
        }
        [self requset:self.dic];
    }];
    
}




-(void)creatTableView1
{
    
    self.table1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 110) style:(UITableViewStylePlain)];
    self.table1.delegate = self;
    self.table1.dataSource = self;
    self.table1.rowHeight = 200;
//    NSDictionary *dic1 = @{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"client":@"1",@"sort":@"hot",@"limit":@"10",@"version":@"3.0.2",@"start":@"0",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0"};
//    [RequestManager requestWithUrlString:KCommunityURL parDic:dic1 requestType:RequestPOST finish:^(NSData *data) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"++++++++++++++++++++++++%@",dic);
//        self.arr = [communityModel arr:dic];
//        [self.table1 reloadData];
//    } error:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    [self.scr addSubview:self.table1];
}

-(void)cteatTableView2
{
    self.table2 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 110) style:(UITableViewStylePlain)];
    self.table2.delegate = self;
    self.table2.dataSource = self;
    self.table2.rowHeight = 200;
//    NSDictionary *dic1 = @{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"client":@"1",@"sort":@"addtime",@"limit":@"10",@"version":@"3.0.2",@"start":@"0",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0"};
//    [RequestManager requestWithUrlString:KCommunityURL parDic:dic1 requestType:RequestPOST finish:^(NSData *data) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        self.arr2 = [communityModel arr:dic];
//        [self.table1 reloadData];
//    } error:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    [self.scr addSubview:self.table2];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segment.selectedSegmentIndex == 0) {
        return self.arr.count;
    }else{
        return self.arr2.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    communityOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[communityOneTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
    }
    if (self.segment.selectedSegmentIndex == 0) {
        
        communityModel *model = self.arr[indexPath.row];
        [cell creatCell:model];
    }else{
        communityModel *model = self.arr2[indexPath.row];
        [cell creatCell:model];
    }
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.segment.selectedSegmentIndex = self.scr.contentOffset.x / kScreenWidth;
    
    if (self.scr.contentOffset.x / kScreenWidth == 0) {
        
        self.limit = self.isNewChose * 10;
        self.start = 0;
        self.dic[@"sort"] = @"addtime";
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        [self requset:self.dic];
    }else if (self.scr.contentOffset.x / kScreenWidth == 1){
        self.limit = self.isHotChose * 10;
        self.start = 0;
        self.dic[@"sort"] = @"hot";
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        [self requset:self.dic];
        
    }
    

    [self.table1 reloadData];
    [self.table2 reloadData];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDetailViewController *detail = [[CommunityDetailViewController alloc]init];
    if (self.segment.selectedSegmentIndex == 0) {
        
        communityModel *model = self.arr[indexPath.row];
        detail.uid = model.contentid;
    }else{
        communityModel *model = self.arr2[indexPath.row];
        detail.uid = model.contentid;
        
    }
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
