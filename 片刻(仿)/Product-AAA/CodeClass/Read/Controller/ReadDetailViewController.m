//
//  ReadDetailViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "ReadDetailViewController.h"
#import "RootTableView.h"
#import "ReadDetailModel.h"
#import "RightViewController.h"
#import "RootTwoTableViewCell.h"
#import "ReadDetailNoteViewController.h"
@interface ReadDetailViewController ()<UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate>
@property(nonatomic , strong)NSMutableArray *NewArr;
@property(nonatomic , strong)NSMutableArray *Hotarr;
@property(nonatomic , strong)UIButton *btn1;
@property(nonatomic , strong)UIButton *btn2;
@property(nonatomic , strong)UIView *view1;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UITableView *tableview1;
@property(nonatomic , strong)UIScrollView *scr;
@property(nonatomic , assign)BOOL isSelect;
@property(nonatomic , strong)NSMutableDictionary *dic;
@property(nonatomic , assign)NSInteger limit;
@property(nonatomic , assign)NSInteger start;
@property(nonatomic , assign)NSInteger isNewChose;
@property(nonatomic , assign)NSInteger isHotChose;
@property(nonatomic , strong)UIButton *btn;
@end

@implementation ReadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatScrollview];
    [self creatTableView];
    [self creatTableView1];
    self.NewArr = [NSMutableArray array];
    self.Hotarr = [NSMutableArray array];
    self.isNewChose = 1;
    self.isHotChose = 1;
    NSNumber *num = [NSNumber numberWithInteger:self.inter];
    self.limit = 10;
    self.start = 0;
    self.dic = [@{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"typeid":num,@"client":@"1",@"sort":@"addtime",@"limit":[NSString stringWithFormat:@"%ld",(long)self.limit],@"version":@"3.0.2",@"auth":@"Wc06FCrkoq1DCMVzGMTiDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"start":[NSString stringWithFormat:@"%ld",(long)self.start]}mutableCopy];
    [self requset:self.dic];
    
    
    
    self.titleLabel.text = self.title1;
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(215, 58, 20, 1)];
    self.view1.backgroundColor = [UIColor blackColor];
    [self creatBtn1];
    [self creatBtn2];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.view1];
    self.isSelect = YES;
    [self reloadView1];
    [self reloadView2];
    
    

    // Do any additional setup after loading the view.
}


-(void)reloadView1
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.start = 0;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        if (self.isSelect == YES) {
            self.limit = self.isNewChose * 10;
            self.dic[@"sort"] = @"addtime";
        }else if (self.isSelect == NO){
            
            self.limit = self.isHotChose * 10;
            self.dic[@"sort"] = @"hot";
        }
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        [self requset:self.dic];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.start = self.isNewChose * 10;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        self.dic[@"limit"] = @"10";
        if (self.isSelect == YES) {
            self.dic[@"sort"] = @"addtime";
            self.isNewChose += 1;
        }else if (self.isSelect == NO){
            self.dic[@"sort"] = @"hot";
            self.isHotChose += 1;
        }
        [self requset:self.dic];
    }];
    
}

-(void)reloadView2
{
    self.tableview1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.start = 0;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        if (self.isSelect == YES) {
            self.limit = self.isNewChose * 10;
            self.dic[@"sort"] = @"addtime";
        }else if (self.isSelect == NO){
            
            self.limit = self.isHotChose * 10;
            self.dic[@"sort"] = @"hot";
        }
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        [self requset:self.dic];
    }];
    
    self.tableview1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.start = self.isNewChose * 10;
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        self.dic[@"limit"] = @"10";
        if (self.isSelect == YES) {
            self.dic[@"sort"] = @"addtime";
            self.isNewChose += 1;
        }else if (self.isSelect == NO){
            self.dic[@"sort"] = @"hot";
            self.isHotChose += 1;
        }
        [self requset:self.dic];
    }];
    
}


-(void)creatScrollview
{
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40)];
    self.scr.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    self.scr.contentOffset = CGPointMake(0, 0);
    self.scr.delegate = self;
    self.scr.pagingEnabled = YES;
    self.scr.bounces = NO;
    [self.view addSubview:self.scr];
}


-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.scr addSubview:self.tableView];
}


-(void)creatTableView1
{
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 40, kScreenWidth, kScreenHeight - 70) style:(UITableViewStylePlain)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.separatorColor = [UIColor grayColor];
    self.tableview1.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.tableview1.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.scr addSubview:self.tableview1];
}

-(UIButton *)button{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20 + 10, 20, 20)];
        [_btn setImage:[UIImage imageNamed:@"u9_start"] forState:(UIControlStateNormal)];
        [_btn setTitleColor:PkCOLOR(25, 25, 25) forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatBtn1{
    self.btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn1.frame = CGRectMake(200, 25, 40, 30);
    [self.btn1 setTitle:@"NEW" forState:(UIControlStateNormal)];
    [self.btn1.layer setCornerRadius:5];
    self.btn1.backgroundColor = [UIColor blackColor];
    [self.btn1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.btn1 addTarget:self action:@selector(btn1Action) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.btn1];
    
}

-(void)creatBtn2{
    self.btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn2.frame = CGRectMake(300, 25, 40, 30);
    [self.btn2 setTitle:@"HOT" forState:(UIControlStateNormal)];
    self.btn2.backgroundColor = [UIColor grayColor];
    [self.btn2.layer setCornerRadius:5];
    [self.btn2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.btn2 addTarget:self action:@selector(btn2Action) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.btn2];
    
}

-(void)btn1Action
{
    self.isSelect = YES;
    self.limit = self.isNewChose * 10;
    self.start = 0;
    self.dic[@"sort"] = @"addtime";
    self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
    self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
    [self requset:self.dic];
    self.btn2.backgroundColor = [UIColor grayColor];
    self.btn1.backgroundColor = [UIColor blackColor];
    self.scr.contentOffset = CGPointMake(0, 0);
    [self.tableview1 reloadData];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.2 animations:^{
        self.view1.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished){
    }];
}

-(void)btn2Action{
    self.isSelect = NO;
    self.limit = self.isHotChose * 10;
    self.start = 0;
    self.dic[@"sort"] = @"hot";
    self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
    self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
    [self requset:self.dic];
    self.btn1.backgroundColor = [UIColor grayColor];
    self.btn2.backgroundColor = [UIColor blackColor];
    self.scr.contentOffset = CGPointMake(kScreenWidth, 0);
    [self.tableview1 reloadData];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.2 animations:^{
        self.view1.transform = CGAffineTransformMakeTranslation(100, 0);
    } completion:^(BOOL finished){
    }];
}

-(void)requset:(NSDictionary *)dic
{
    [RequestManager requestWithUrlString:KReadURLDetail parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dataDic = dic1[@"data"];
        NSString *s = [NSString stringWithFormat:@"%@",dataDic[@"total"]];
        if ([s isEqualToString:@"0"]) {
            NSLog(@"==============================没有更多数据");
            [self.tableView.mj_footer endRefreshing];
            [self.tableview1.mj_footer endRefreshing];
            return ;
        }
        if (self.start == 0) {
            if (self.isSelect) {
                [self.NewArr removeAllObjects];
            }else if (self.isSelect == NO){
                [self.Hotarr removeAllObjects];
            }
        }
        if (self.isSelect) {
            NSMutableArray *arr1 = [ReadDetailModel arr:dic1];
            for (ReadDetailModel *model in arr1) {
                [self.NewArr addObject:model];
            }
        }else{
            NSMutableArray *arr2 = [ReadDetailModel arr:dic1];
            for (ReadDetailModel *model in arr2) {
                [self.Hotarr addObject:model];
            }
        }
        [self.tableView reloadData];
        [self.tableview1 reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableview1.mj_footer endRefreshing];
        [self.tableview1.mj_header endRefreshing];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSelect == YES) {
        return self.NewArr.count;
    }else{
        return self.Hotarr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
    if (!cell) {
        cell = [[RootTwoTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
    }
    if (self.isSelect) {
        ReadDetailModel *model = self.NewArr[indexPath.row];
        
        [cell creatCell1:model];
        return cell;
    }else{
        ReadDetailModel *model = self.Hotarr[indexPath.row];
        [cell creatCell1:model];
        return cell;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scr.contentOffset.x == 0) {
        self.isSelect = YES;
        self.limit = self.isNewChose * 10;
        self.start = 0;
        self.dic[@"sort"] = @"addtime";
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        [self requset:self.dic];
        self.btn2.backgroundColor = [UIColor grayColor];
        self.btn1.backgroundColor = [UIColor blackColor];
        [UIView animateWithDuration:0.2 animations:^{
            self.view1.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished){
        }];
    }else{
        self.isSelect = NO;
        self.limit = self.isHotChose * 10;
        self.start = 0;
        self.dic[@"sort"] = @"hot";
        self.dic[@"limit"] = [NSString stringWithFormat:@"%ld",(long)self.limit];
        self.dic[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.start];
        [self requset:self.dic];
        self.btn1.backgroundColor = [UIColor grayColor];
        self.btn2.backgroundColor = [UIColor blackColor];
        [UIView animateWithDuration:0.2 animations:^{
            self.view1.transform = CGAffineTransformMakeTranslation(100, 0);
        } completion:^(BOOL finished){
        }];
        
    }
    [self.tableView reloadData];
    [self.tableview1 reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scr.contentOffset.x == 0) {
        ReadDetailModel *model = self.NewArr[indexPath.row];
        ReadDetailNoteViewController *read = [[ReadDetailNoteViewController alloc]init];
        read.myID = model.myID;
        [self.navigationController pushViewController:read animated:YES];
    }else
    {
        ReadDetailModel *model = self.Hotarr[indexPath.row];
        ReadDetailNoteViewController *read = [[ReadDetailNoteViewController alloc]init];
        read.myID = model.myID;
        [self.navigationController pushViewController:read animated:YES];
    }
    
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
