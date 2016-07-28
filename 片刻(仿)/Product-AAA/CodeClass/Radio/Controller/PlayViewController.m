//
//  PlayViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "PlayViewController.h"
#import "MusicManager.h"
#import "NSString+Html.h"
#import "RootPlayTableViewCell.h"
#import "RadioDetailModel.h"
#import "RadioModel.h"
#import "DownLoad.h"
#import "DownLoadManager.h"
#import "MusicDownloadTable.h"
#import "CALayer+PauseAimate.h"
#import "ArrayManager.h"
#import "EncodeManager.h"
#import "UIImage+ImageEffects.h"
@interface PlayViewController ()<UIScrollViewDelegate , UITableViewDataSource , UITableViewDelegate>
@property (strong , nonatomic) UIImageView *imageV;
@property (strong , nonatomic) UILabel *tit;
@property (strong , nonatomic) UILabel *timeL;
@property (nonatomic , strong) NSTimer *timer;
@property (strong , nonatomic) UISlider *Progress;
@property (nonatomic , strong) UIButton *btn;
@property (nonatomic , strong) UIScrollView *scr;
@property (strong , nonatomic) UIImageView *aixinImage;
@property (strong , nonatomic) UILabel *aixinLabel;
@property (strong , nonatomic) UIImageView *pinglunImage;
@property (strong , nonatomic) UILabel *pinglunLabel;
@property (strong , nonatomic) UIButton *xiazaiButton;
@property (nonatomic , strong) UIWebView *webView;
@property (nonatomic , strong) UITableView *table;
@property (nonatomic , assign) NSInteger angle;
@property (nonatomic , strong) UIButton *choseButton;
@property (nonatomic , strong) UIView *view111;
@property (nonatomic , strong) UILongPressGestureRecognizer *pan1;
@property (nonatomic , strong) NSTimer *downTime;
@property (nonatomic , strong) NSMutableArray *downLoadArr;
@property (nonatomic , strong) NSMutableArray *frameArray;
@property (nonatomic , strong) UIButton *collectBtn;
@property (nonatomic , strong) UIButton *shareBtn;
@property (nonatomic , strong) UIButton *timeBtn;
@property (strong , nonatomic) IBOutlet UIView *xian;
@property (strong , nonatomic) IBOutlet UIPageControl *pageSlide;
@property (strong , nonatomic) IBOutlet UIButton *playBtn;
@property (assign , nonatomic) BOOL danmu;
@property (strong , nonatomic) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *danmuLabel;
@end

@implementation PlayViewController


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}

-(void)creatView1{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60)];
   UIImage *ima = [UIImage imageNamed:@"1001.jpg"];
    UIImage *img = [ima applyDarkEffect];
    image.image = img;
   
    self.view111 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth, 40, kScreenWidth, kScreenHeight)];
    [self.view111 addSubview:image];
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(55, 35, kScreenWidth - 110, kScreenWidth - 110)];
    
    self.tit = [[UILabel alloc]initWithFrame:CGRectMake(100,35+kScreenWidth-110 +20, kScreenWidth - 200, 30)];
    self.tit.textAlignment = NSTextAlignmentCenter;
    self.aixinImage = [[UIImageView alloc]initWithFrame:CGRectMake(70, 45+kScreenWidth-110 +62+10 - 20, 30, 30)];
    self.aixinImage.image = [UIImage imageNamed:@"hearts"];
    self.aixinLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,45+kScreenWidth-110 +62+10 - 20, 40, 30)];
    self.aixinLabel.text = @"2";
    self.pinglunImage = [[UIImageView alloc]initWithFrame:CGRectMake(100+140 + 20, 45+kScreenWidth-110 +62+10 -20, 30, 30)];
    self.pinglunLabel = [[UILabel alloc]initWithFrame:CGRectMake(100+140+30 + 20,45+kScreenWidth-110 +62+10 - 20, 30, 30)];
    self.pinglunImage.image = [UIImage imageNamed:@"comment"];
    self.pinglunLabel.text = @"2";
    self.pinglunImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.pinglunImage addGestureRecognizer:tap];
    
    self.xiazaiButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.xiazaiButton.frame = CGRectMake(50, kScreenWidth-110 +62+30+30+20, 50, 30);
    [self.xiazaiButton setImage:[UIImage imageNamed:@"u148_end"] forState:(UIControlStateNormal)];
    [self.xiazaiButton addTarget:self action:@selector(downLoadAction:) forControlEvents:(UIControlEventTouchUpInside)];
  self.Progress = [[UISlider alloc]initWithFrame:CGRectMake(100, kScreenWidth-110 +62+30+30+20, kScreenWidth-200, 30)];
    //[self.Progress addTarget:self action:@selector(slideAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.timeL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 100, kScreenWidth-110 +62+30+30+20, 50, 30)];
    [self.view111 addSubview:self.imageV];
    [self.view111 addSubview:self.tit];
    [self.view111 addSubview:self.aixinImage];
    [self.view111 addSubview:self.aixinLabel];
    [self.view111 addSubview:self.pinglunLabel];
    [self.view111 addSubview:self.pinglunImage];
    [self.view111 addSubview:self.xiazaiButton];
    [self.view111 addSubview:self.Progress];
    [self.view111 addSubview:self.timeL];
    [self.scr addSubview:self.view111];
    MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
    NSArray *arr1 = [table selectAll];
    if (arr1.count > 0) {
        for (NSArray *arr2 in arr1) {
            RadioDetailModel *model = self.array[self.inter];
            if ([arr2 containsObject:model.musicUrl]) {
                [self.xiazaiButton setTintColor:[UIColor orangeColor]];
                return;
            }
        }
    }
    [self.xiazaiButton setTintColor:[UIColor blueColor]];
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
-(void)creatBtn{
    self.choseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.choseButton.frame = CGRectMake(100, 25, 30, 30);
    [self.choseButton setTitle:@"顺序" forState:(UIControlStateNormal)];
    [self.choseButton addTarget:self action:@selector(change) forControlEvents:(UIControlEventTouchUpInside)];
    self.collectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.collectBtn.frame = CGRectMake(160, 25, 30, 30);
    [self.collectBtn setImage:[UIImage imageNamed:@"star"] forState:(UIControlStateNormal)];
    [self.collectBtn addTarget:self action:@selector(collectAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shareBtn.frame = CGRectMake(220, 25, 30, 30);
    [self.shareBtn setImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
    //[self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.timeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.timeBtn.frame = CGRectMake(280, 25, 30, 30);
    [self.timeBtn setImage:[UIImage imageNamed:@"time"] forState:(UIControlStateNormal)];
    [self.timeBtn addTarget:self action:@selector(timetimeAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.choseButton.tintColor = [UIColor blackColor];
    self.collectBtn.tintColor = [UIColor blackColor];
    self.shareBtn.tintColor = [UIColor blackColor];
    self.timeBtn.tintColor = [UIColor blackColor];
    [self.view addSubview:self.choseButton];
    [self.view addSubview:self.collectBtn];
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.timeBtn];
}


-(void)timetimeAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示 " message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入定时时间";
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length == 0) {
            }
        if (alert.textFields[0].text.length > 0) {
            NSString *st = alert.textFields[0].text;
            CGFloat f = [st floatValue];
            self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 60, 15, 50, 50)];
            self.timeLabel.text = st;
            [self.view addSubview:self.timeLabel];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeLabelAction) userInfo:nil repeats:YES];
            [self performSelector:@selector(turnOff) withObject:self afterDelay:f];
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)timeLabelAction
{
    CGFloat f = [self.timeLabel.text floatValue];
    f --;
    self.timeLabel.text = [NSString stringWithFormat:@"%.1f",f];
}

-(void)turnOff
{
    [self.danmuLabel removeFromSuperview];
    [[MusicManager shareInstance] playerPlayAndPause];
    if (self.musicArr.count > 0 || self.Collect == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
    [self.timeLabel removeFromSuperview];
}


-(void)tapAction
{
    
   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(danmuLabelAction) userInfo:nil repeats:YES];
    if (self.danmu == NO) {
        [self alertControllerShowWithTitle:@"弹幕开启" message:nil];
        self.danmu = YES;
        [self.pinglunImage setTintColor:[UIColor orangeColor]];
        
    }else{
        [self alertControllerShowWithTitle:@"弹幕关闭" message:nil];
        self.danmu = NO;
        [self.pinglunImage setTintColor:[UIColor blackColor]];
    }
}

-(void)danmuLabelAction
{
    
    if ([MusicManager shareInstance].state == NO || self.danmu == NO) {
        return;
    }
    NSArray *danmakus = @[@"233333333",@"春卫大帅比",@"哈哈哈哈",@"么么哒",@"\(^o^)/~",@"~~~~(>_<)~~~~ ",@"天朝威武",@"O(∩_∩)O~",@"😄😄👌👌",@"呦呦呦"];
    NSString *str = [danmakus objectAtIndex:rand()%danmakus.count];
    self.danmuLabel = [[UILabel alloc]init];
    self.danmuLabel.frame =CGRectMake(320, rand()%200, 200, 150);
    self.danmuLabel.text = str;
    self.danmuLabel.textColor = [self randomColor];
    //将label加入本视图中去。
    [self.view addSubview:self.danmuLabel];
    [self move:self.danmuLabel];
    
}


-(void)move:(UILabel*)_label
{
    [UIView animateWithDuration:5 animations:^{
        _label.frame = CGRectMake(-250, _label.frame.origin.y, _label.frame.size.width, _label.frame.size.height);
    } completion:^(BOOL finished) {
        [_label removeFromSuperview];
    }
     ];
}
-(UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}





-(void)collectAction
{
    NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
    [ArrayManager shareManager].Array = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:filePth arrayKey:@"array"]mutableCopy];
   
    NSInteger Inter = [MusicManager shareInstance].indter;
    RadioDetailModel *model = self.array[Inter];
    if ([ArrayManager shareManager].Array.count == 0 || [ArrayManager shareManager].Array == nil) {
        [self alertControllerShowWithTitle:@"已收藏" message:nil];
        self.collectBtn.tintColor = [UIColor redColor];
        NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
        NSLog(@"%@",filePth);
        [[ArrayManager shareManager].Array addObject:model];
    NSData *data = [[EncodeManager shareInstance]archiverArray:[ArrayManager shareManager].Array arrayKey:@"array"];
        [data writeToFile:filePth atomically:YES];
        return;
    }else  {
        for (RadioDetailModel *model1 in [ArrayManager shareManager].Array) {
            if ([model1.musicUrl isEqualToString:model.musicUrl]) {
                [self alertControllerShowWithTitle:@"取消收藏" message:nil];
                self.collectBtn.tintColor = [UIColor blackColor];
                [[ArrayManager shareManager].Array removeObject:model1];
                NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
                NSLog(@"%@",filePth);
                NSData *data = [[EncodeManager shareInstance]archiverArray:[ArrayManager shareManager].Array arrayKey:@"array"];
                [data writeToFile:filePth atomically:YES];
                return;
            }
        }
    }
    
    [[ArrayManager shareManager].Array addObject:model];
        self.collectBtn.tintColor = [UIColor redColor];
        [self alertControllerShowWithTitle:@"已收藏" message:nil];
        NSString *filePth1 = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
        NSLog(@"%@",filePth1);
        NSData *data = [[EncodeManager shareInstance]archiverArray:[ArrayManager shareManager].Array arrayKey:@"array"];
        [data writeToFile:filePth1 atomically:YES];
}

// 展示AlertController
- (void)alertControllerShowWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [self performSelector:@selector(alertMiss:) withObject:alert afterDelay:1];
}
// AlertController自动消失
- (void)alertMiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

-(void)creatTable
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(2 * kScreenWidth, 40, kScreenWidth, kScreenHeight - 40 - 160) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.rowHeight = 100;
    [self.scr addSubview:self.table];
}

-(void)creatScrollView
{
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 60 - 100)];
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.contentSize = CGSizeMake(3 * kScreenWidth, 0);
    self.scr.contentOffset = CGPointMake(kScreenWidth, 0);
    self.scr.pagingEnabled = YES;
    self.scr.bounces = NO;
    self.scr.delegate = self;
    [self.scr setScrollEnabled:YES];
    [self.view addSubview:self.scr];
}


-(void)viewWillAppear:(BOOL)animated
{
    if (self.Collect == YES) {
        self.collectBtn.tintColor = [UIColor redColor];
    }else{
    NSInteger ii =  [MusicManager shareInstance].indter;
        NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
        [ArrayManager shareManager].Array = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:filePth arrayKey:@"array"]mutableCopy];

    for (RadioDetailModel *model in [ArrayManager shareManager].Array ) {
        if ([model.musicUrl isEqualToString:[MusicManager shareInstance].array[ii]]) {
            self.collectBtn.tintColor = [UIColor redColor];
            return;
        } else {
            self.collectBtn.tintColor = [UIColor blackColor];
        }
    }
}
    [self.table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 19, kScreenWidth, 1)];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    self.navigationController.navigationBar.hidden = YES;
    [self creatScrollView];
    [self creatTable];
    [self creatBtn];
    [self.view addSubview:self.btn];
    [self creatView1];
    self.frameArray = [NSMutableArray array];
    NSInteger inte = [[NSUserDefaults standardUserDefaults]integerForKey:@"play"];
    NSLog(@"///////////////%ld",inte);
    [MusicManager shareInstance].inter = inte;
    if (inte == 0) {
        [self.choseButton setTitle:@"顺序" forState:(UIControlStateNormal)];
    }else if (inte == 1){
        [self.choseButton setTitle:@"随机" forState:(UIControlStateNormal)];
    }else if (inte == 2){
        [self.choseButton setTitle:@"单曲" forState:(UIControlStateNormal)];
        [MusicManager shareInstance].indter = [MusicManager shareInstance].indter;
    }
    self.Progress.value = 0;
    if (self.musicArr.count > 0) {
        [self otherreloadViewWithIndex:self.musicInter];
    }else{
        [self reloadViewWithIndex:self.inter];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.003 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.timer fire];
    
    
    if ([MusicManager shareInstance].state == YES) {
        [self.playBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@3x"]
        forState:(UIControlStateNormal)];
    }else{
        //如果是暂停 让其显示播放按钮
        [self.playBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@3x"] forState:(UIControlStateNormal)];
}
    [self.playBtn setTintColor:[UIColor orangeColor]];
}





-(void)otherreloadViewWithIndex:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSArray *arr in self.musicArr) {
        [array addObject:arr[1]];
    }
    [MusicManager shareInstance].array = array;
    [MusicManager shareInstance].indter  = self.musicInter;
    NSArray *music = self.musicArr[index];
    [self.imageV.layer setMasksToBounds:YES];
    [self.imageV.layer setCornerRadius:(kScreenWidth-110)/2.0];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:music[2]]];
    self.tit.text = music[4];
    [[MusicManager shareInstance]replaceItemWithUrlString:[MusicManager shareInstance].array[self.musicInter]];
}

-(void)reloadViewWithIndex:(NSInteger)index
{
    RadioDetailModel *radio = self.array[index];
    self.tit.text = radio.uname;
    NSString *html = radio.webview_url;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60 - 100)];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:radio.coverimg]];
    [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:html]]];
    [self.scr addSubview:self.webView];
    [self.imageV.layer setMasksToBounds:YES];
    [self.imageV.layer setCornerRadius:(kScreenWidth-110)/2.0];
    if (radio.isChose == NO) {
        [[MusicManager shareInstance]replaceItemWithUrlString:[MusicManager shareInstance].array[index]];
        radio.isChose = YES;
    }else{
    }
    NSLog(@"%@",self.arr[self.inter]);
}

-(void)timerAction
{
    if ([MusicManager shareInstance].player.currentTime.timescale == 0 || [MusicManager shareInstance].player.currentItem.duration.timescale == 0) {
        return;
    }
    long long int currentTime = [MusicManager shareInstance].player.currentTime.value / [MusicManager shareInstance].player.currentTime.timescale;
    long long int allTime = [MusicManager shareInstance].player.currentItem.duration.value / [MusicManager shareInstance].player.currentItem.duration.timescale;
    self.timeL.text = [NSString stringWithFormat:@"%02lld:%02lld",allTime / 60 , allTime % 60];
    self.Progress.maximumValue = allTime;
    self.Progress.value = currentTime;
    if (self.Progress.value >= allTime - 1) {
        RadioDetailModel *model1 = self.array[[MusicManager shareInstance].indter];
        model1.isChose = NO;
        [[MusicManager shareInstance]playerAutoNext];
        [self reloadViewWithIndex:[MusicManager shareInstance].indter];
        RadioDetailModel *model2 = self.array[[MusicManager shareInstance].indter];
        model2.isChose = YES;
        NSLog(@"-----------------%ld",[MusicManager shareInstance].indter);
    }
    if ([MusicManager shareInstance].state == NO) {
        return;
    }else{
        [UIView animateWithDuration:0.001 animations:^{
            self.imageV.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 360.0));
        } completion:^(BOOL finished) {
            self.angle += 1;
        }];
    }
    
    
    
    
}






-(void)back
{
    if (self.musicArr.count > 0 || self.Collect == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)change
{
    [MusicManager shareInstance].inter = [[NSUserDefaults standardUserDefaults]integerForKey:@"play"];
    [MusicManager shareInstance].inter++;
    if ([MusicManager shareInstance].inter == 1) {
        [self.choseButton setTitle:@"随机" forState:(UIControlStateNormal)];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"play"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else if ([MusicManager shareInstance].inter == 2) {
        [self.choseButton setTitle:@"单曲" forState:(UIControlStateNormal)];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"play"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [MusicManager shareInstance].indter = [MusicManager shareInstance].indter;
    }else if ([MusicManager shareInstance].inter == 3) {
        [self.choseButton setTitle:@"顺序" forState:(UIControlStateNormal)];
        [MusicManager shareInstance].inter = 0;
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"play"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageSlide.currentPage = self.scr.contentOffset.x / kScreenWidth;
    [self.table reloadData];
}

- (IBAction)pageAction:(id)sender {
    UIPageControl *page = sender;
    self.scr.contentOffset = CGPointMake(page.currentPage * kScreenWidth, 0);
}

- (IBAction)aboveAction:(id)sender {
    if (self.Collect == YES) {
        [MusicManager shareInstance].state = YES;
        [self.playBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@3x"] forState:(UIControlStateNormal)];
        [[MusicManager shareInstance]playerAbove];
        self.inter--;
        if (self.inter < 0) {
            RadioDetailModel *model = self.array[self.array.count - 1];
            [[MusicManager shareInstance] replaceItemWithUrlString:model.musicUrl];
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
            self.tit.text =model.uname;
            self.inter = self.array.count - 1;
            }else{
            RadioDetailModel *model = self.array[self.inter];
            [[MusicManager shareInstance]replaceItemWithUrlString:model.musicUrl];
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
            self.tit.text =model.uname;
        }
        }else{
    [MusicManager shareInstance].state = YES;
    [self.playBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@3x"] forState:(UIControlStateNormal)];
    [[MusicManager shareInstance]playerAbove];
    RadioDetailModel *model = self.array[self.inter];
    model.isChose = NO;
    [self reloadViewWithIndex:[MusicManager shareInstance].indter];
    if (self.musicArr.count > 0) {
        NSArray *music = self.musicArr[[MusicManager shareInstance].indter];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:music[2]]];
        self.tit.text = music[4];
    }
}
    NSInteger ii =  [MusicManager shareInstance].indter;
    NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
    [ArrayManager shareManager].Array = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:filePth arrayKey:@"array"]mutableCopy];
    for (RadioDetailModel *model in [ArrayManager shareManager].Array ) {
        if ([model.musicUrl isEqualToString:[MusicManager shareInstance].array[ii]]) {
            self.collectBtn.tintColor = [UIColor redColor];
            return;
        } else {
            self.collectBtn.tintColor = [UIColor blackColor];
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImage" object:nil];
MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
    NSArray *arr1 = [table selectAll];
    if (arr1.count > 0) {
        for (NSArray *arr2 in arr1) {
            NSInteger inter = [MusicManager shareInstance].indter;
            RadioDetailModel *model = self.array[inter];
            if ([arr2 containsObject:model.musicUrl]) {
                [self.xiazaiButton setTintColor:[UIColor orangeColor]];
                return;
            }
        }
    }
    [self.xiazaiButton setTintColor:[UIColor blueColor]];
}

- (IBAction)playAction:(id)sender {
    if ([MusicManager shareInstance].state == YES) {
        [[MusicManager shareInstance]playerPlayAndPause];
        [MusicManager shareInstance].state = NO;
    }else if ([MusicManager shareInstance].state == NO){
        [[MusicManager shareInstance]playerPlayAndPause];
        [MusicManager shareInstance].state = YES;
    }
    //如果是播放 让其显示暂停按钮
    if ([MusicManager shareInstance].state == YES) {
        [self.playBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@3x"] forState:(UIControlStateNormal)];
    }else{
        //如果是暂停 让其显示播放按钮
        [self.playBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted@3x"] forState:(UIControlStateNormal)];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImage" object:nil];
}

- (IBAction)nextAction:(id)sender {
    if (self.Collect == YES) {
        [MusicManager shareInstance].state = YES;
        [self.playBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@3x"] forState:(UIControlStateNormal)];
      [[MusicManager shareInstance]playerNext];
        self.inter++;
        if (self.inter > self.array.count - 1) {
            RadioDetailModel *model = self.array[0];
            self.inter = 0;
            [[MusicManager shareInstance] replaceItemWithUrlString:model.musicUrl];
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
            self.tit.text =model.uname;
      }else{
            RadioDetailModel *model = self.array[self.inter];
            [[MusicManager shareInstance]replaceItemWithUrlString:model.musicUrl];
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
            self.tit.text =model.uname;
        }
}else{
     [MusicManager shareInstance].state = YES;
    [self.playBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted@3x"] forState:(UIControlStateNormal)];
    [[MusicManager shareInstance]playerNext];
    RadioDetailModel *model = self.array[self.inter];
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"play"] == 2) {
        [MusicManager shareInstance].inter = 2;
        NSInteger inte = [MusicManager shareInstance].indter;
        NSString *url = [MusicManager shareInstance].array[inte];
        [[MusicManager shareInstance]replaceItemWithUrlString:url];
    }else{
        model.isChose = NO;
    }
    [self reloadViewWithIndex:[MusicManager shareInstance].indter];
    if (self.musicArr.count > 0) {
        NSArray *music = self.musicArr[[MusicManager shareInstance].indter];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:music[2]]];
        self.tit.text = music[4];
    }
    }
    NSLog(@"++++++%ld",[MusicManager shareInstance].indter);
    NSInteger ii =  [MusicManager shareInstance].indter;
    NSString *filePth = [[EncodeManager shareInstance]creatOrGetDocWithWithDocName:@"array.txt" type:CachesType];
    [ArrayManager shareManager].Array = [[[EncodeManager shareInstance]unArchiverArrayWithFilePath:filePth arrayKey:@"array"]mutableCopy];
        for (RadioDetailModel *model in [ArrayManager shareManager].Array ) {
            if ([model.musicUrl isEqualToString:[MusicManager shareInstance].array[ii]]) {
                self.collectBtn.tintColor = [UIColor redColor];
                return;
            } else {
                self.collectBtn.tintColor = [UIColor blackColor];
            }
        }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImage" object:nil];
MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
    NSArray *arr1 = [table selectAll];
    if (arr1.count > 0) {
        for (NSArray *arr2 in arr1) {
            NSInteger inter = [MusicManager shareInstance].indter;
            RadioDetailModel *model = self.array[inter];
            if ([arr2 containsObject:model.musicUrl]) {
                [self.xiazaiButton setTintColor:[UIColor orangeColor]];
                return;
            }
        }
    }
    [self.xiazaiButton setTintColor:[UIColor blueColor]];
}

//小下载
-(void)downLoadAction:(UIButton *)btn
{
    self.downLoadArr = [NSMutableArray array];
    NSString *url = [MusicManager shareInstance].array[[MusicManager shareInstance].indter];
    
    RadioDetailModel *model = self.array[[MusicManager shareInstance].indter];
    MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
    NSArray *arr1 = [table selectAll];
    if (arr1.count > 0) {
        for (NSArray *arr2 in arr1) {
            if ([arr2 containsObject:model.musicUrl]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"这首歌已被下载" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(alertDismiss:) withObject:alert afterDelay:1];
                return;
            }
        }
    }
    [self.downLoadArr addObject:model];
    DownLoadManager *manager = [DownLoadManager defaultManager];
    DownLoad *task = [manager creatDownload:url];
    NSLog(@"+++++++++++++%@",url);
    [task start];
    [task monitorDownload:^(long long bytesWritten, NSInteger progress, long long allTimes) {
        NSLog(@"%lld,%ld",bytesWritten,progress);
    } DidDownload:^(NSString *savePath, NSString *url) {
        NSLog(@"++++++++++++++++++++%@",savePath);
        //保存数据
        //title, musicUrl, musicImg ,musicPath
        MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
        [table creatTable];
        [table insertIntoTable:@[model.title,model.musicUrl,model.imgUrl,savePath,model.uname]];
        [self.xiazaiButton setTintColor:[UIColor orangeColor]];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Identifier = [NSString stringWithFormat:@"%ld",indexPath.row];
    RootPlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[RootPlayTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:Identifier];
    }
    RadioDetailModel *model = self.array[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"by: %@",model.uname];
    cell.titLabel.text = model.title;
    MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
    NSArray *arr1 = [table selectAll];
    for (NSArray *arr2 in arr1) {
        if ([arr2 containsObject:model.musicUrl]) {
            cell.progressView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        }
    }
    if (model.downType == downLoaded) {
        [cell.btn setImage:[UIImage imageNamed:@"u148_end.png"] forState:(UIControlStateNormal)];
    }else if (model.downType == downLoad){
        [cell.btn setImage:[UIImage imageNamed:@"u148_end.png"] forState:(UIControlStateNormal)];
}else{
        [cell.btn setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
for (NSValue *value in self.frameArray) {
            CGRect frame = [value CGRectValue];
            cell.progressView.frame = frame;
        }
    }
    [cell.btn addTarget:self action:@selector(downLoadV:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

-(void)alertDismiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

-(void)downLoadV:(UIButton *)btn
{
    RootPlayTableViewCell *cell = (RootPlayTableViewCell *)btn.superview.superview;
    NSIndexPath *path = [self.table indexPathForCell:cell];
    RadioDetailModel *model = self.array[path.row];
    model.isDownLoad = !model.isDownLoad;
    NSString *url = model.musicUrl;
    DownLoadManager *manager = [DownLoadManager defaultManager];
    DownLoad *task = [manager creatDownload:url];
    MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
    NSArray *arr1 = [table selectAll];
    if (arr1.count > 0) {
        for (NSArray *arr2 in arr1) {
            if ([arr2 containsObject:model.musicUrl]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"这首歌已被下载" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(alertDismiss:) withObject:alert afterDelay:1];
                return;
            }
        }
    }
        [task monitorDownload:^(long long bytesWritten, NSInteger progress, long long allTimes) {
            NSLog(@"%ld",progress);
            CGRect frame = cell.progressView.frame;
            frame.origin.x = kScreenWidth / 100 * progress - CGRectGetWidth(cell.preferredFocusedView.frame);
            cell.progressView.frame = frame;
            NSValue *value = [NSValue valueWithCGRect:frame];
            [self.frameArray addObject:value];
            model.downType = downLoading;
        } DidDownload:^(NSString *savePath, NSString *url) {
            //title, musicUrl, musicImg ,musicPath
            MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
            [table creatTable];
            [table insertIntoTable:@[model.title,model.musicUrl,model.imgUrl,savePath,model.uname]];
            [cell.btn setImage:[UIImage imageNamed:@"u148_end.png"] forState:(UIControlStateNormal)];
}];
        if (model.isDownLoad == NO) {
            [cell.btn setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
            model.downType = downLoading;
            [task start];
        }else{
            [cell.btn setImage:[UIImage imageNamed:@"u148_end.png"] forState:(UIControlStateNormal)];
            model.downType = downLoad;
            [task stop];
        }
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
