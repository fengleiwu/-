//
//  DownLoadViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "DownLoadViewController.h"
#import "DownLoadTableViewCell.h"
#import "MusicDownloadTable.h"
#import "PlayViewController.h"
#import "MusicManager.h"
#import "ArrayManager.h"
#import "EncodeManager.h"
@interface DownLoadViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic , strong)UIButton *btn;
@property (nonatomic , strong)UIButton *editBtn;
@property (nonatomic , assign)BOOL isSelect;

@end

@implementation DownLoadViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    MusicDownloadTable *music = [[MusicDownloadTable alloc]init];
     NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
    [ArrayManager shareManager].Array = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:filePth arrayKey:@"array"]mutableCopy];
   self.arr = [NSMutableArray array];
    self.arr = [[music selectAll]mutableCopy];
    self.isSelect = NO;
    if (self.aixinChose == YES && [ArrayManager shareManager].Array.count == 0) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.center = self.view.center;
        lab.text = @"你还没有收藏任何Ting";
        [self.view addSubview:lab];
    }else if (self.aixinChose == YES && [ArrayManager shareManager].Array.count > 0){
        [self creatTableView];
    }else if (self.arr.count == 0 ) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.center = self.view.center;
        lab.text = @"你还没有下载任何Ting";
        [self.view addSubview:lab];
    }else{
        [self creatTableView];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.table reloadData];
}

-(void)creatTableView
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 100 - 10) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.rowHeight = 60;
    [self.view addSubview:self.table];
}

-(UIButton *)button{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20 + 10, 20, 20)];
        [_btn setImage:[UIImage imageNamed:@"u9_start"] forState:(UIControlStateNormal)];
        [_btn setTitleColor:PkCOLOR(25, 25, 25) forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(showRootVC:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}

-(void)showRootVC:(UIButton *)but
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImage" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[DownLoadTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
    }
    if (self.aixinChose == YES) {
        RadioDetailModel *model = [ArrayManager shareManager].Array[indexPath.row];
        cell.titleL.text = model.title;
        cell.name.text = [NSString stringWithFormat:@"by:%@",model.uname];
        return cell;
    }else{
    NSArray *array = self.arr[indexPath.row];
    cell.titleL.text = array[0];
    cell.name.text = [NSString stringWithFormat:@"by:%@",array[4]];
    return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.aixinChose == YES) {
        return [ArrayManager shareManager].Array.count;
    }else{
    return self.arr.count;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
if (self.aixinChose == YES) {
        PlayViewController *play = [[PlayViewController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:play];
        RadioDetailModel *model = [ArrayManager shareManager].Array[indexPath.row];
        NSMutableArray *arr = [NSMutableArray array];
        for (RadioDetailModel *model in [ArrayManager shareManager].Array) {
            [arr addObject:model.musicUrl];
        }
        play.array = [ArrayManager shareManager].Array;
        play.arr = arr;
        play.Collect = YES;
        play.inter = indexPath.row;
        [MusicManager shareInstance].array = arr;
        [MusicManager shareInstance].indter = indexPath.row;
    [[MusicManager shareInstance]replaceItemWithUrlString:model.musicUrl];
        [MusicManager shareInstance].play(model);
        [self presentViewController:navc animated:YES completion:nil];
}else{
      PlayViewController *play = [[PlayViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:play];
    NSArray *musicArray = self.arr[indexPath.row];
    play.musicArr = self.arr;
    play.musicInter = indexPath.row;
    [MusicManager shareInstance].MusicPlay(musicArray);
        [self presentViewController:navc animated:YES completion:nil];
}
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.aixinChose == YES) {
        return YES;
    }else{
        return NO;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[ArrayManager shareManager].Array removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
        NSLog(@"%@",filePth);
        NSData *data = [[EncodeManager shareInstance]archiverArray:[ArrayManager shareManager].Array arrayKey:@"array"];
        [data writeToFile:filePth atomically:YES];
        [self.table reloadData];
        NSLog(@"删!");
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
