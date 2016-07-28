//
//  RootViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootViewController.h"
#import "RightViewController.h"
#import "CarouselView.h"
#import "RadioDetailViewController.h"
#import "RadioDetailModel.h"
#import "MusicManager.h"
#import "DownLoadViewController.h"
#import "LoginViewController.h"
#import "ArrayManager.h"
#import "RadioModel.h"
#define CAGradientLayerH  (kScreenHeight / 3.0)
@interface RootViewController ()<UITableViewDataSource , UITableViewDelegate , UISearchResultsUpdating , UISearchControllerDelegate , UISearchBarDelegate>
@property (nonatomic , strong)NSArray *controllers;
@property (nonatomic , strong)NSArray *name;
@property (nonatomic , strong)NSIndexPath *index;
@property (nonatomic , strong)RightViewController *rightVC;
@property (nonatomic , strong)UINavigationController *myNaviVC;
@property (nonatomic , strong)UIButton *downBtn;
@property (nonatomic , strong)UIButton *loveBtn;
@property (nonatomic , strong)UIButton *textBtn;
@property (nonatomic , strong)UIButton *panBtn;
@property (nonatomic , strong)UIImageView *personImg;
@property (nonatomic , strong)UIButton *loginBtn;

@property (nonatomic , strong)UITableView *tableview;
@property (nonatomic , strong)UIButton *btn;


@property(nonatomic , strong)NSMutableDictionary *parDic;
@property(nonatomic , strong)NSMutableArray *searchBigArray;
@property(nonatomic , strong)NSMutableArray *searchLittleArray;
@property(nonatomic , strong)NSMutableArray *searchDataArray;
@property(nonatomic , strong)NSString *searchString;
@property(nonatomic , strong)UISearchController *searchVC;
@property(nonatomic , assign)BOOL searchShow;

//@property (nonatomic , strong)UIButton *regisBtn;

@end

@implementation RootViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGradientLayer];
       [self creatView];
    [self creatTopView];
    [self initTableView];
    
    self.searchShow = NO;
    self.parDic = [@{@"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"limit":@"9",@"start":@"9",@"version":@"3.0.6"}mutableCopy];
    [RequestManager requestWithUrlString:KPostLowURL parDic:self.parDic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *parDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dataDic = parDic[@"data"];
       self.searchString = [NSString stringWithFormat:@"%@",dataDic[@"total"]];
        NSLog(@"s+++++++++++++++++++++++%@",self.searchString);
        NSDictionary *dic1 = @{@"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"limit":self.searchString,@"start":@"9",@"version":@"3.0.6"};
        [RequestManager requestWithUrlString:KPostLowURL parDic:dic1 requestType:RequestPOST finish:^(NSData *data) {
            NSDictionary *parDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.searchBigArray = [RadioModel arr3:parDic];
            NSLog(@"===========%ld",self.searchBigArray.count);
        } error:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyMissAction) name:@"key" object:nil];
    
    
    
    // Do any additional setup after loading the view.
}
//wufenglei.EMDemo


-(void)viewWillAppear:(BOOL)animated
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self searchBarCancelButtonClicked:self.searchVC.searchBar];

}

-(void)keyMissAction
{
    [self searchBarCancelButtonClicked:self.searchVC.searchBar];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.searchVC.searchBar resignFirstResponder];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchVC.searchBar resignFirstResponder];
}


-(void)creatView
{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, kScreenHeight - 50, 40, 40)];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(60, kScreenHeight - 50, 200, 30)];
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(60, kScreenHeight - 25, 100, 20)];
    label1.font = [UIFont systemFontOfSize:15];
    lable2.font = [UIFont systemFontOfSize:10];
    label1.textColor = [UIColor whiteColor];
    lable2.textColor = [UIColor whiteColor];
    self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn.frame = CGRectMake(kScreenWidth - 120, kScreenHeight - 45, 30, 30);
    self.btn.hidden = YES;
    [MusicManager shareInstance].play = ^(RadioDetailModel *model){
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        lable2.text = [NSString stringWithFormat:@"by:%@",model.uname];
        label1.text = model.title;
        
        if ( [MusicManager shareInstance].state == YES) {
            [self.btn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@2x"] forState:(UIControlStateNormal)];
            [self.btn addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
            }else{
            [self.btn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@2x"] forState:(UIControlStateNormal)];
            [self.btn addTarget:self action:@selector(stopAction:) forControlEvents:(UIControlEventTouchUpInside)];
                self.btn.hidden = NO;
        }
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeImage) name:@"changeImage " object:nil];
    };
    [MusicManager shareInstance].MusicPlay = ^(NSArray *arr){
        label1.text = arr[0];
        lable2.text = [NSString stringWithFormat:@"by:%@",arr[4]];
        [imageV sd_setImageWithURL:[NSURL URLWithString:arr[2]]];
                if ([MusicManager shareInstance].state == YES) {
                    [self.btn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@2x"] forState:(UIControlStateNormal)];
                    [self.btn addTarget:self action:@selector(stopAction:) forControlEvents:(UIControlEventTouchUpInside)];
                }else if ([MusicManager shareInstance].state == NO){
                    [self.btn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@2x"] forState:(UIControlStateNormal)];
                    [self.btn addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
                }
        self.btn.hidden = NO;
};
    [self.view addSubview:imageV];
    [self.view addSubview:label1];
    [self.view addSubview:lable2];
    [self.view addSubview:self.btn];
}
-(void)changeImage
{
    if ( [MusicManager shareInstance].state == YES) {
        [self.btn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@2x"] forState:(UIControlStateNormal)];
    }else{
        [self.btn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@2x"] forState:(UIControlStateNormal)];
    }
    
}

-(void)stopAction:(UIButton *)btn
{
    [[MusicManager shareInstance] playerPlayAndPause];
    [MusicManager shareInstance].state = NO;
    [btn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@2x"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(playAction:)forControlEvents:(UIControlEventTouchUpInside)];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"animation" object:nil];
    
    
}

-(void)playAction:(UIButton *)btn1
{
    [[MusicManager shareInstance] playerPlayAndPause];
    [MusicManager shareInstance].state = YES;
    [btn1 setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@2x"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(stopAction:)forControlEvents:(UIControlEventTouchUpInside)];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"animation" object:nil];
    
    
}


-(void)initGradientLayer{
    //CAGradientLayerH
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    gradientLayer.frame = CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20);
    gradientLayer.colors = @[(id)PkCOLOR(180, 180, 180).CGColor,(id)PkCOLOR(100, 90, 100).CGColor,(id)PkCOLOR(40, 40, 40).CGColor];
    [self.view.layer addSublayer:gradientLayer];
    
}


-(void)creatTopView
{
    self.personImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 50, 50)];
    if ([NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"icon"]] != nil) {
        
        [self.personImg sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"icon"]]];
    }else{
    self.personImg.image = [UIImage imageNamed:@"skull"];
    }
    [self.personImg.layer setMasksToBounds:YES];
    [self.personImg.layer setCornerRadius:25];
    self.loginBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.loginBtn.frame = CGRectMake(90, 45, 100, 60);
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"uname"] != nil) {
        [self.loginBtn setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"uname"]forState:(UIControlStateNormal)];
    }else{
    [self.loginBtn setTitle:@"登录 | 注册" forState:(UIControlStateNormal)];
    }
    self.downBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.downBtn.frame = CGRectMake(30, 130, 40, 40);
    [self.downBtn setImage:[UIImage imageNamed:@"download"] forState:(UIControlStateNormal)];
    [self.downBtn addTarget:self action:@selector(turnToDownLoad) forControlEvents:(UIControlEventTouchUpInside)];
    self.downBtn.tintColor = [UIColor whiteColor];
    self.loveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.loveBtn.frame = CGRectMake(100, 130, 40, 40);
    [self.loveBtn setImage:[UIImage imageNamed:@"hearts"] forState:(UIControlStateNormal)];
    self.loveBtn.tintColor = [UIColor whiteColor];
    [self.loveBtn addTarget:self action:@selector(loveAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.textBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.textBtn.frame = CGRectMake(170, 130, 40, 40);
    [self.textBtn setImage:[UIImage imageNamed:@"comments"] forState:(UIControlStateNormal)];
    self.textBtn.tintColor = [UIColor whiteColor];
    self.panBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.panBtn.frame = CGRectMake(240, 130, 40, 40);
    [self.panBtn setImage:[UIImage imageNamed:@"edit"] forState:(UIControlStateNormal)];
    self.panBtn.tintColor = [UIColor whiteColor];
    
    
    
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchVC.searchBar sizeToFit];
    //self.searchVC.searchBar.frame = CGRectMake(20, 200, kScreenWidth/5*4 -40, 50);
   // self.searchVC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchVC.dimsBackgroundDuringPresentation = NO;
    self.searchVC.hidesNavigationBarDuringPresentation = YES;
    self.definesPresentationContext = YES;
    self.searchVC.searchBar.placeholder = @"电台搜索";
    self.searchVC.searchResultsUpdater = self;
    self.searchVC.searchBar.delegate = self;
    self.searchVC.delegate = self;
    
    [self.view addSubview:self.personImg];
    [self.view addSubview:self.loginBtn];
    //[self.view addSubview:self.regisBtn];
    [self.view addSubview:self.downBtn];
    [self.view addSubview:self.loveBtn];
    [self.view addSubview:self.textBtn];
    [self.view addSubview:self.panBtn];
}


//在搜索框输入的时候会调用该方法, 每一次输入都会调用该方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    //用谓词进行检索
    // 谓词搜索是开发中常用的搜索方式，是系统自带的搜索方式，减轻开发人员压力
    // 谓词搜索模式 固定格式写法 self contains [cd] %@
    // @""里边 填写self contains [cd] searchBar.text
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", searchController.searchBar.text];
    self.searchLittleArray = [NSMutableArray array];
    //self.searchDataArray = [NSMutableArray array];
    for (RadioModel *model in self.searchBigArray) {
        [self.searchLittleArray addObject:model.title];
    }
    self.searchDataArray = [[NSMutableArray alloc]initWithArray:[self.searchLittleArray filteredArrayUsingPredicate:predicate]];
    NSLog(@"+++++++++++++%@",self.searchDataArray);
    self.searchShow = YES;
    [self.tableview reloadData];
    
    // 通过谓词索索 将检验出来的数据 从原有数据中提取出来 放到新的数组中 也就是从self.dataArray中的数据检测提取出来后 放到检测后的数组中self.arr中
    
    // 将状态置换中搜索状态
    
    //验证检索出得数组
    //更新数据
}


//点击cancel时触发 也就是点击取消搜索时触发 我们需要置换_isShow状态
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"点击了取消搜索");
    self.searchShow = NO;
    [self.tableview reloadData];
    
}
#pragma mark -- UISearchControllerDelegate
//将要模态出searchController时触发
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"将要模态出现searchController");
    
}
//已经模态出searchController时触发
- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"已经模态出现searchController");
}
//将要模态消失searchController时触发
- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"将要模态消失searchController");
    
}
//已经模态消失searchController时触发
- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"已经模态消失searchController");
    self.searchShow = NO;
    [self.tableview reloadData];
    
}

//模态推出searchController 时触发, 点击搜索弹出搜索框之前触发
- (void)presentSearchController:(UISearchController *)searchController
{
    //self.navigationController.navigationBar.hidden = YES;
    
    NSLog(@"搜索框出现之前触发");
}






-(void)loveAction:(UIButton *)btn
{
    DownLoadViewController *down = [[DownLoadViewController alloc]init];
    down.aixinChose = YES;
    [self presentViewController:down animated:YES completion:nil];
}

-(void)loginAction
{
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:login];
    login.loginSucess = ^{
        [self.loginBtn setTitle:[UserInfoManager getUserName] forState:(UIControlStateNormal)];
        [self.personImg sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"icon"]]];
    };
    
    [self presentViewController:naVC animated:YES completion:nil];
}




-(void)turnToDownLoad
{
    DownLoadViewController *down = [[DownLoadViewController alloc]init];
    down.aixinChose = NO;
    [self presentViewController:down animated:YES completion:nil];
}

-(void)initTableView{
    _controllers = @[@"RadioViewController",@"ReadViewController",@"CommunityViewController",@"ProductViewController",@"SetViewController"];
    _name = @[@"电台",@"阅读",@"社区",@"良品",@"设置"];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 20 + CAGradientLayerH, kScreenWidth, kScreenHeight - 20 - CAGradientLayerH - 64) style:(UITableViewStylePlain)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = PkCOLOR(40, 40, 40);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = self.tableview.height/_name.count;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rootCell"];
    [self.view addSubview:self.tableview];
    self.index = [NSIndexPath indexPathForRow:0 inSection:0];
    //[tableview selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self.tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    //初始化子视图
    
    _rightVC = [[NSClassFromString(_controllers[0])alloc]init];
    _rightVC.titleLabel.text = _name[0];
    _myNaviVC = [[UINavigationController alloc]initWithRootViewController:_rightVC];
    _myNaviVC.navigationBar.hidden = YES;
    self.tableview.tableHeaderView = self.searchVC.searchBar;

    [self.view addSubview:_myNaviVC.view];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchShow == YES) {
        return self.searchDataArray.count;
    }else{
        
        return _name.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchShow == YES) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell" forIndexPath:indexPath];
        cell.textLabel.text = self.searchDataArray[indexPath.row];
        return cell;
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell" forIndexPath:indexPath];
    cell.textLabel.text = _name[indexPath.row];
    cell.textLabel.textColor = PkCOLOR(80, 80, 80);
    cell.textLabel.font = [UIFont systemFontOfSize:cell.height / 4.0];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    cell.backgroundColor = PkCOLOR(40, 40, 40);
    if (indexPath.row == 0 && self.index == indexPath) {
        cell.textLabel.textColor = PkCOLOR(240, 240 , 240);
    }
    return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchShow == YES) {
        NSString *st = self.searchDataArray[indexPath.row];
        for (RadioModel *model in self.searchBigArray) {
            if ([model.title isEqualToString:st]) {
                RadioDetailViewController *radio = [[RadioDetailViewController alloc]init];
                radio.url = model.radioid;
                radio.tit = model.title;
                radio.isSearch = YES;
                [self dismissViewControllerAnimated:YES completion:nil];
                UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:radio];
                naVC.navigationBar.hidden = YES;
                [self presentViewController:naVC animated:YES completion:nil];
                 return;
            }
        }
    }
    
    self.index = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = PkCOLOR(240, 240 , 240);
    if ([_rightVC isMemberOfClass:[NSClassFromString(_controllers[indexPath.row])class]]) {
        NSLog(@"重复点击");
        [_rightVC ChangeFrameWithType:MOVETYPELEFT];
        return;
    }
    [_myNaviVC.view removeFromSuperview];
    //初始化子视图
    
    //_rightVC isKindOfClass:<#(__unsafe_unretained Class)#>
    //_rightVC isMemberOfClass:<#(__unsafe_unretained Class)#>
    _rightVC = [[NSClassFromString(_controllers[indexPath.row])alloc]init];
    _rightVC.titleLabel.text = _name[indexPath.row];
    _myNaviVC = [[UINavigationController alloc]initWithRootViewController:_rightVC];
    _myNaviVC.navigationBar.hidden = YES;
    [self.view addSubview:_myNaviVC.view];
    //_myNaviVC.view.frame = CGRectMake(kScreenWidth - kMoveDistance, 0, kScreenWidth, kScreenHeight);
    CGRect newFrame = _myNaviVC.view.frame;
    newFrame.origin.x = kScreenWidth - kMoveDistance;
    _myNaviVC.view.frame = newFrame;
    [_rightVC ChangeFrameWithType:MOVETYPELEFT];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = PkCOLOR(80, 80, 80);
    cell.backgroundColor = PkCOLOR(40, 40, 40);
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
