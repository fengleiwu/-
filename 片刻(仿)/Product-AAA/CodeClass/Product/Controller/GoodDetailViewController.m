//
//  GoodDetailViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "GoodDetailViewController.h"

@interface GoodDetailViewController ()
@property (nonatomic , strong)UIWebView *web;
@property (nonatomic , strong)UIButton *btn;
@end

@implementation GoodDetailViewController


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
    [self.view addSubview:self.btn];
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60)];
    NSDictionary *dic =@{ @"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"contentid":self.contentid,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"version":@"3.0.6"};
    [RequestManager requestWithUrlString:KGooDDetailURL parDic:dic requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *data1 = dic2[@"data"];
        NSDictionary *post = data1[@"postsinfo"];
        NSDictionary *share = post[@"shareinfo"];
        NSString *url = share[@"url"];
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
