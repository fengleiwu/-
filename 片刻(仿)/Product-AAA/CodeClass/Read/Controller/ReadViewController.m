//
//  ReadViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "ReadViewController.h"
#import "CarouselView.h"
#import "ReadModel.h"
#import "RootCollectView.h"
#import "RootTableView.h"
#import "ReadDetailViewController.h"
//#import "UIwebViewController.h"
#import "ReadDetailNoteViewController.h"
@interface ReadViewController ()
@property(nonatomic , strong)NSMutableArray *arr1;
@property(nonatomic , strong)NSMutableArray *arr2;
@property(nonatomic , strong)NSMutableArray *arr3;
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr1 = [NSMutableArray array];
    self.arr2 = [NSMutableArray array];
    self.arr3 = [NSMutableArray array];
    
    
    self.view.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight-60);
    
    [RequestManager requestWithUrlString:KReadURL parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.arr1 = [ReadModel arr1:dic];
        self.arr2 = [ReadModel arr:dic];
        
        for (ReadModel *model in self.arr2) {
            
            [self.arr3 addObject:model.img];
        }
        CarouselView *view1 = [[CarouselView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 150) imageURLs:self.arr3];
        
        view1.imageClick = ^(NSInteger inter){
            ReadModel *model = self.arr2[inter];
            NSArray *arr = [model.url componentsSeparatedByString:@"/"];
            NSString *html = arr[3];
            //UIwebViewController *web = [[UIwebViewController alloc]init];
            ReadDetailNoteViewController *web = [[ReadDetailNoteViewController alloc]init];
            web.myID = html;
            NSLog(@"%@",model.url);
            [self.navigationController pushViewController:web animated:YES];
        };
        
        RootCollectView *rootCollect = [[RootCollectView alloc]initWithFrame:CGRectMake(0, 220, kScreenWidth, kScreenWidth) imageURLs:self.arr1];
        
        
        rootCollect.inter = 2;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(trunOther:) name:@"turn" object:nil];
        [self.view addSubview:rootCollect];
        [self.view addSubview:view1];
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

    // Do any additional setup after loading the view.
}


-(void)trunOther:(NSNotification *)notification
{
    ReadDetailViewController *readDetail = [[ReadDetailViewController alloc]init];
    //NSNumber *num = notification.object;
    ReadModel *model = notification.object;
    readDetail.inter = model.type;
    readDetail.title1 = model.name;
    
    [self.navigationController pushViewController:readDetail animated:YES];
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
