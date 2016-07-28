//
//  RadioDetailViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RadioDetailViewController.h"
#import "CarouselView.h"
#import "RadioDetailModel.h"
#import "RootRadioDetailTableViewCell.h"
#import "PlayViewController.h"
#import "MusicManager.h"
@interface RadioDetailViewController ()<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic , strong)UITableView *table;
@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UIView *view1;
@property(nonatomic , strong)NSMutableArray *arr;
@property(nonatomic , strong)NSMutableArray *arr1;
@property(nonatomic , strong)UIImageView *image;
@property(nonatomic , strong)UILabel *label;
@property(nonatomic , strong)UILabel *label1;
@property(nonatomic , strong)UILabel *label2;
@property(nonatomic , strong)UIImageView *img;
@property(nonatomic , strong)UIButton *btn;
@property(nonatomic , strong)NSString *urlS;

@property(nonatomic , strong)NSString *imageURL;

@property(nonatomic , strong)NSString *string1;
@property(nonatomic , strong)NSString *string2;
@property(nonatomic , strong)NSString *string3;
@property(nonatomic , strong)NSString *string4;



@end

@implementation RadioDetailViewController




-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImage" object:nil];
    if (self.isSearch == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr1 = [NSMutableArray array];
    NSArray *arr = [self.url componentsSeparatedByString:@"/"];
    self.urlS = arr.lastObject;
    //[self creatView];
    [self.view addSubview:self.btn];
    NSDictionary *dic =@{@"client":@"1",@"deviceid":@"63A94D37-33-33F9-40FF-9EBB-481182338873",@"radioid":self.urlS,@"version":@"3.0.4"};
    [RequestManager requestWithUrlString:KRadioURLDetail parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"dic1==================%@",dic1);
        NSMutableArray *arr1 = [RadioDetailModel arr1:dic1];
        for (RadioDetailModel *model in arr1) {
            self.imageURL = model.coverimg;
            
        }
        NSMutableArray *arr2 = [RadioDetailModel arr2:dic1];
        
        for (RadioDetailModel *model in arr2) {
            self.string1 = model.icon;
            self.string2 = model.uname;
            self.string3 = model.desc;
            self.string4 = model.musicvisitnum;
            self.titleLabel.text = self.tit;
            
        }
        self.arr = [RadioDetailModel arr3:dic1];
        for (RadioDetailModel *model in self.arr) {
            [self.arr1 addObject:model.musicUrl];
        }
        
        [self creatTableView];
        [self.table reloadData];
    } error:^(NSError *error) {
        
    }];
    
    
    // Do any additional setup after loading the view.
}


-(void)creatImage:(NSString *)url{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 260)];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:url]];
    //[self.view addSubview:self.imageV];
}


-(void)creatView
{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 270, kScreenWidth, 150)];
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(30, 20, 30, 30)];
    self.image.backgroundColor = [UIColor redColor];
    [self.image.layer setMasksToBounds:YES];
    [self.image.layer setCornerRadius:15];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(65, 25, 150, 20)];
    self.label.font = [UIFont systemFontOfSize:16];
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 200, 70)];
    self.label1.numberOfLines = 0;
    self.label1.font = [UIFont systemFontOfSize:15];
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 100, 30, 20, 20)];
    self.img.image = [UIImage imageNamed:@"WiFi"];
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 75, 30, 75, 20)];
    self.label2.font = [UIFont systemFontOfSize:14];
    [self.view1 addSubview:self.image];
    [self.view1 addSubview:self.label2];
    [self.view1 addSubview:self.label1];
    [self.view1 addSubview:self.label];
    [self.view1 addSubview:self.img];
    //[self.view addSubview:self.view1];
}

-(void)creatTableView{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width , self.view.frame.size.height - 60) style:(UITableViewStyleGrouped)];
    self.table.separatorColor = [UIColor grayColor];
    self.table.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerNib:[UINib nibWithNibName:@"RootRadioDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ss"];
    self.table.rowHeight = 120;
    [self.view addSubview:self.table];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootRadioDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss" forIndexPath:indexPath];
    
    RadioDetailModel *model = self.arr[indexPath.row];
    //    [[MusicManager shareInstance]replaceItemWithUrlString:model.musicUrl];
    
    
    if (model.isPlay == YES && [MusicManager shareInstance].state == YES) {
        [cell.stateBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@2x"] forState:(UIControlStateNormal)];
        [cell.stateBtn addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }else{
        [cell.stateBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@2x"] forState:(UIControlStateNormal)];
        [cell.stateBtn addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }

    [cell creatCell:model];
    return cell;
}



-(void)playAction:(UIButton *)btn
{
    RootRadioDetailTableViewCell *cell = (RootRadioDetailTableViewCell *)btn.superview.superview;
        NSIndexPath *path = [self.table indexPathForCell:cell];
    RadioDetailModel *model = self.arr[path.row];
    [MusicManager shareInstance].play(model);
    [[MusicManager shareInstance]playerPlayAndPause];
    if (model.isPlay == YES) {
        [MusicManager shareInstance].state = NO;
        [cell.stateBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@2x"] forState:(UIControlStateNormal)];
        model.isPlay = NO;
    }else if (model.isPlay == NO){
        //[[MusicManager shareInstance]playerPlayAndPause];
        [MusicManager shareInstance].state = YES;
        [cell.stateBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@2x"]forState:(UIControlStateNormal)];
        for (RadioDetailModel *model1 in self.arr) {
            model1.isPlay = NO;
            model1.isChose = NO;
        }
        model.isPlay = YES;
        model.isChose = YES;
        [[MusicManager shareInstance]replaceItemWithUrlString:model.musicUrl];
        
        [self.table reloadData];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayViewController *play = [[PlayViewController alloc]init];
    
    play.inter = indexPath.row;
    play.arr = self.arr1;
    play.array = self.arr;//大的
    RadioDetailModel *model = self.arr[indexPath.row];
    for (RadioDetailModel *model in self.arr) {
        model.isPlay = NO;
    }
    model.isPlay = YES;
    [MusicManager shareInstance].play(model);
    [MusicManager shareInstance].array = self.arr1;//小的
    [MusicManager shareInstance].indter = indexPath.row;
    play.isSelect = YES;
    [self.navigationController pushViewController:play animated:YES];
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioDetailModel *model = self.arr[indexPath.row];
    model.isChose = NO;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 400)];
    view1.backgroundColor = [UIColor whiteColor];
    [self creatImage:self.imageURL];
    [self creatView];
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.string1]];
    self.label.text = [NSString stringWithFormat:@"by:%@",self.string2];
    self.label1.text = self.string3;
    self.label2.text = [NSString stringWithFormat:@"%@",self.string4];
    [view1 addSubview:self.view1];
    [view1 addSubview:self.imageV];
    return view1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 400;
}




-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
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
