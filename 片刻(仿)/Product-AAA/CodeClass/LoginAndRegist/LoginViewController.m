//
//  LoginViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#define kLoginUrl  @"http://api2.pianke.me/user/login" //登录接口的地址
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *youxiangLabel;

@property (strong, nonatomic) IBOutlet UITextField *mimaLabel;



@end


@implementation LoginViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)loginBtn:(id)sender {
    [RequestManager requestWithUrlString:kLoginUrl parDic:@{@"email":_youxiangLabel.text,@"passwd":_mimaLabel.text} requestType:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *data1 = dic[@"data"];
        if ([dic[@"result"]integerValue] == 0) {
            NSLog(@"登入失败");
        }else
        {
            [UserInfoManager conserveUserAuth:@"data"];
            [UserInfoManager conserveUserIcon:dic[@"data"]];
            [UserInfoManager conserveUserID:dic[@"data"][@"uid"]];
            [UserInfoManager conserveUserName:dic[@"data"][@"uname"]];
            [[NSUserDefaults standardUserDefaults]setObject:data1[@"icon"] forKey:@"icon"];
            [[NSUserDefaults standardUserDefaults]setObject:data1[@"auth"] forKey:@"auth"];
            [[NSUserDefaults standardUserDefaults]setObject:data1[@"uname"] forKey:@"uname"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"注册成功");
            if (self.loginSucess) {
                self.loginSucess();
                
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        NSLog(@"+++++++++++++++++++++%@",dic);
    } error:^(NSError *error) {
        
    }];

}
- (IBAction)regisBtn:(id)sender {
    RegistViewController *regist = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    // Do any additional setup after loading the view from its nib.
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
