//
//  CommunityDetailViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import "NSString+Html.h"
@interface CommunityDetailViewController ()
@property (nonatomic , strong)UIWebView *web;
@property (nonatomic , strong)UIButton *btn;
@end

@implementation CommunityDetailViewController
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60)];
    NSLog(@"-------------------%@",self.uid);
    NSDictionary *dic = @{@"contentid":self.uid,@"client":@"1",@"&deviceid=63A94D37-33F9-40FF-9EBB-481182338873":@"auth",@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0&version":@"3.0.2"};
    [RequestManager requestWithUrlString:KCommunityDetailURL parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@",dic1);
        NSDictionary *data1 = dic1[@"data"];
        NSDictionary *post = data1[@"postsinfo"];
        //NSString *html = post[@"html"];
        NSDictionary *share = post[@"shareinfo"];
        NSString *url = share[@"url"];
        //        url = [NSString importStyleWithHtmlString:url];
        //        [self.web loadHTMLString:url baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
        [self.web loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]];
        [self.view addSubview:self.web];
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    // Do any additional setup after loading the view.
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
