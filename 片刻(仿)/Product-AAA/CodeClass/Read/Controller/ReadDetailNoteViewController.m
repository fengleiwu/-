//
//  ReadDetailNoteViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "ReadDetailNoteViewController.h"
#import "NSString+Html.h"
#import "pinglunViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface ReadDetailNoteViewController ()<UIWebViewDelegate>
@property (nonatomic , strong)UIWebView *web;
@property (nonatomic , strong)UIButton *btn;
@property (nonatomic , strong)UIButton *aBtn;
@property (nonatomic , strong)UIButton *pinglunBtn;
@property (nonatomic , strong)UIButton *aixinBtn;
@property (nonatomic , strong)UILabel *pinglunLabel;
@property (nonatomic , strong)UILabel *aixinLabel;
@property (nonatomic , strong)UIButton *shareBtn;
@property (nonatomic , strong)NSString *uid;
@property (nonatomic , strong)UISlider *slide;
@property (nonatomic , assign)NSInteger inter;
@property (nonatomic , strong)UISlider *colorSlide;
@property (nonatomic , assign)BOOL isFont;
@end

@implementation ReadDetailNoteViewController

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

-(void)creataBtn
{
    self.aBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.aBtn.frame = CGRectMake(70, 30, 20, 20);
    [self.aBtn setImage:[UIImage imageNamed:@"xbox_A"] forState:(UIControlStateNormal)];
    self.aBtn.tintColor = [UIColor blackColor];
    [self.aBtn addTarget:self action:@selector(fontAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
    [self.view addSubview:self.aBtn];
}

-(void)creatpingLunBtn
{
    self.pinglunBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.pinglunBtn.frame = CGRectMake(140, 30, 20, 20);
    [self.pinglunBtn setImage:[UIImage imageNamed:@"comment"] forState:(UIControlStateNormal)];
    self.pinglunBtn.tintColor = [UIColor blackColor];
    [self.view addSubview:self.pinglunBtn];
}

-(void)creataiXinBtn
{
    self.aixinBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.aixinBtn.frame = CGRectMake(220, 30, 20, 20);
    [self.aixinBtn setImage:[UIImage imageNamed:@"hearts"] forState:(UIControlStateNormal)];
    self.aixinBtn.tintColor = [UIColor blackColor];
    [self.view addSubview:self.aixinBtn];
}

-(void)creatpinglunLabel
{
    self.pinglunLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 30, 40, 20)];
    self.pinglunLabel.font = [UIFont systemFontOfSize:14];
    [self.pinglunBtn addTarget:self action:@selector(pinglunAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.pinglunLabel];
}

-(void)pinglunAction
{
    pinglunViewController *pinglun = [[pinglunViewController alloc]init];
    if (self.uid == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(alertDismiss:) withObject:alert afterDelay:1];
    }else{  pinglun.uid = self.uid;
    pinglun.flag = self.inter;
    [self.navigationController pushViewController:pinglun animated:YES];
    }
}

-(void)fontAction
{
    if (self.isFont == NO) {
        [UIView animateWithDuration:1 animations:^{
            self.slide.transform = CGAffineTransformMakeTranslation(0, -30);
            self.colorSlide.transform = CGAffineTransformMakeTranslation(0, -60);
        } completion:^(BOOL finished) {
            self.isFont = YES;
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.slide.transform = CGAffineTransformMakeTranslation(0, 0);
            self.colorSlide.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            self.isFont = NO;
        }];
    }
}

-(void)slideAction
{
    NSString *botySise=[[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.fontSize='%fpx'",self.slide.value ];
    //文章标题大小
    NSString *titleSise=[[NSString alloc] initWithFormat:@"document.getElementsByTagName('h1')[0].style.fontSize='%fpx'",
                         self.slide.value + 7];
    [self.web stringByEvaluatingJavaScriptFromString:botySise];
    [self.web stringByEvaluatingJavaScriptFromString:titleSise];
    
}

-(void)alertDismiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

-(void)creataixinLabel
{
    self.aixinLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 30, 40, 20)];
    self.aixinLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.aixinLabel];
}

-(void)creatShareBtn
{
    self.shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shareBtn.frame = CGRectMake(300, 30, 40, 20);
    [self.shareBtn setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)
     ];
    self.shareBtn.tintColor = [UIColor blackColor];
    [self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.shareBtn];
}

-(void)shareAction
{
    NSArray* imageArray = @[[UIImage imageNamed:@"1001.jpg"]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]title:@"分享标题"type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
       NSArray *shareArr = @[@"1",@"6",@"7",@"10",@"997",@"998"];
 [ShareSDK showShareActionSheet:nil items:shareArr shareParams:shareParams
onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
            case SSDKResponseStateSuccess:{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
            message:nil delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
        case SSDKResponseStateFail: {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                }
                       
            }];
    }

}
//contentid=54603f3d8ead0e195000028e&client=1&deviceid=63A94D37-33F9-40FF-9EBB-481182338873,&auth=Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0&version=3.0.2



- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFont = NO;
    [self creataBtn];
    [self creataiXinBtn];
    [self creatpingLunBtn];
    [self creataixinLabel];
    [self creatpinglunLabel];
    [self creatShareBtn];
    [self.view addSubview:self.btn];
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60)];
    NSMutableDictionary *dic =[@{@"contentid":self.myID,@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"version":@"3.0.2"}mutableCopy];
    [RequestManager requestWithUrlString:KReadURLNoteDetail parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *data1 = dic[@"data"];
        NSString *html = data1[@"html"];
        NSDictionary *list = data1[@"counterList"];
        self.uid = data1[@"contentid"];
        html = [NSString importStyleWithHtmlString:html];
        [self.web loadHTMLString:html baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
        self.web.delegate = self;
        [self.view addSubview:self.web];
        self.slide = [[UISlider alloc]initWithFrame:CGRectMake(0, kScreenHeight+10 , kScreenWidth, 10)];
        self.slide.minimumValue = 15;
        self.slide.maximumValue = 30;
        self.slide.value = 22;
        [self.slide addTarget:self action:@selector(slideAction) forControlEvents:(UIControlEventValueChanged)];
        [self.view addSubview:self.slide];
        self.colorSlide = [[UISlider alloc]initWithFrame:CGRectMake(0, kScreenHeight + 10, kScreenWidth, 10)];
        self.colorSlide.maximumValue = 10;
        self.colorSlide.minimumValue = 0;
        [self.colorSlide addTarget:self action:@selector(colorAction) forControlEvents:(UIControlEventValueChanged)];
        [self.view addSubview:self.colorSlide];
        self.pinglunLabel.text = [NSString stringWithFormat:@"%@",list[@"comment"]];
        self.inter = (NSInteger)list[@"comment"];
        self.aixinLabel.text = [NSString stringWithFormat:@"%@",list[@"like"]];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];


    // Do any additional setup after loading the view.
}


-(void)colorAction
{
    NSArray *arr = @[@"red",@"orange",@"yellow",@"green",@"blue",@"purple",@"black",@"gray",@"browm",@"magenta",@"cyan"];
        NSString *color = [[NSString alloc]initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '%@'",arr[(NSInteger)self.colorSlide.value]];
        [self.web stringByEvaluatingJavaScriptFromString:color];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    CGFloat f = self.slide.value;
//    [self.web stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];
    
    
//    jsString = "document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'purple'"
//    
//    webView.stringByEvaluatingJavaScriptFromString(jsString)
    
    
//    NSString *color = [[NSString alloc]initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '%@'",@"purple"];
//    [self.web stringByEvaluatingJavaScriptFromString:color];
    
    
    
    
    
//    //文章文字大小
//    NSString *botySise=[[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.fontSize='%dpx'",20];
//    //文章标题大小
//    NSString *titleSise=[[NSString alloc] initWithFormat:@"document.getElementsByTagName('h1')[0].style.fontSize='%dpx'",
//                         27];
//    [self.web stringByEvaluatingJavaScriptFromString:botySise];
//    [self.web stringByEvaluatingJavaScriptFromString:titleSise];
    
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
