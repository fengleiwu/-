//
//  RadioViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RadioViewController.h"
#import "CarouselView.h"
#import "RadioModel.h"
#import "RequestManager.h"
#import "RootCollectView.h"
#import "RootTableViewCell.h"
#import "MusicManager.h"
#import "RadioDetailViewController.h"
@interface RadioViewController ()<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic , strong)NSMutableArray *arr1;
@property(nonatomic , strong)NSMutableArray *arr2;
@property(nonatomic , strong)NSMutableArray *arr3;
@property(nonatomic , strong)NSMutableArray *arr4;
@property(nonatomic , strong)UITableView *table;

@property(nonatomic,strong)CABasicAnimation *animation;

@property(nonatomic , strong)NSMutableDictionary *parDic;
//记录start的值
@property(nonatomic , assign)NSInteger index;
@property(nonatomic , assign)NSInteger limit;
@property(nonatomic , strong)UIView *hearView;
@property(nonatomic , strong)UIImageView *musicV;

@end

@implementation RadioViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}





-(void)viewWillAppear:(BOOL)animated
{
    if ([MusicManager shareInstance].state == YES) {
        self.animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
        //设置起始值
        self.animation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
        //设置最终值
        self.animation.toValue = [NSValue valueWithCGSize:CGSizeMake(40, 40)];
        self.animation.duration = 1;
        self.animation.repeatCount = FLT_MAX;
        //设置代理 才会执行 动画开始和结束的代理方法
        self.animation.delegate = self;
        [self.musicV.layer addAnimation:self.animation forKey:nil];
        }else if ([MusicManager shareInstance].state == NO){
        [self.musicV.layer removeAllAnimations];
    }
}

-(void)anat
{
    if ([MusicManager shareInstance].state) {
        [self.musicV.layer addAnimation:self.animation forKey:nil];
        }else
    {
        [self.musicV.layer removeAllAnimations];
    }

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(anat) name:@"animation" object:nil];
    [self creatTableView];
    self.musicV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 30, 20, 20)];
    self.musicV.image = [UIImage imageNamed:@"musical_notes"];
    [self.view addSubview:self.musicV];

    self.arr1 = [NSMutableArray array];
    self.arr2 = [NSMutableArray array];
    self.arr3 = [NSMutableArray array];
    self.arr4 = [NSMutableArray array];
    self.parDic = [@{@"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"limit":@"9",@"start":@"9",@"version":@"3.0.6"}mutableCopy];
    [self requestData];
    self.index = 9;
    self.limit = 1;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //把start再变成0
        self.index = 9;
        //根据index修改字典
        self.parDic[@"limit"] = [NSString stringWithFormat:@"%ld",self.limit * 9];
        self.parDic[@"start"] = @"9";
        //把数组里面的元素全部清空掉
        [self requestData];
    }];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.limit += 1;
        self.index = self.limit * 9;
        //根据index修改字典里面的值
        self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        self.parDic[@"limit"] = @"9";
        [self requestData];
    }];
    self.hearView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 350)];
    [RequestManager requestWithUrlString:KRadioURL parDic:nil requestType:(RequestGET) finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.arr1 = [RadioModel arr1:dic];
        self.arr2 = [RadioModel arr2:dic];
        for (RadioModel *model in self.arr1) {
            [self.arr4 addObject:model.img];
        }
        CarouselView *view1 = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210) imageURLs:self.arr4];
        
        __block RadioViewController *radio1 = self;
        view1.imageClick = ^(NSInteger inter){
            RadioModel *model = self.arr1[inter];
            RadioDetailViewController *radio = [[RadioDetailViewController alloc]init];
            radio.url = model.url;
            [radio1.navigationController pushViewController:radio animated:YES];
        };
        RootCollectView *rootCollect = [[RootCollectView alloc]initWithFrame: CGRectMake(0, 220, kScreenWidth, 130) imageURLs:self.arr2];
        rootCollect.inter = 1;
        rootCollect.imageClick = ^(NSInteger inter){
            RadioModel *model = self.arr2[inter];
            RadioDetailViewController *radio = [[RadioDetailViewController alloc]init];
            radio.url = model.radioid;
            [radio1.navigationController pushViewController:radio animated:YES];
        };
        [self.hearView addSubview:view1];
        [self.hearView addSubview:rootCollect];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    // Do any additional setup after loading the view.
}

-(void)requestData
{
    [RequestManager requestWithUrlString:KPostLowURL parDic:self.parDic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *parDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dataDic = parDic[@"data"];
        NSString *s = [NSString stringWithFormat:@"%@",dataDic[@"total"]];
        if ([s isEqualToString:@"0"]) {
            NSLog(@"没有更多数据");
            [self.table.mj_footer endRefreshing];
            return ;
        }
        //如果是下拉刷新 清空数组
        if (self.index == 0) {
            [self.arr3 removeAllObjects];
            
        }
        NSArray *array = [RadioModel arr3:parDic];
        for (RadioModel *model in array) {
            [self.arr3 addObject:model];
        }
        //停止菊花
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}





-(void)creatTableView{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width , self.view.frame.size.height-60) style:(UITableViewStyleGrouped)];
    self.table.separatorColor = [UIColor grayColor];
    self.table.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr3.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[RootTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        
    }
    RadioModel *model = self.arr3[indexPath.row];
    [cell creatCell:model];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioModel *model = self.arr3[indexPath.row];
    RadioDetailViewController *radio = [[RadioDetailViewController alloc]init];
    radio.url = model.radioid;
    radio.tit = model.title;
    [self.navigationController pushViewController:radio animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.hearView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 350;
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
