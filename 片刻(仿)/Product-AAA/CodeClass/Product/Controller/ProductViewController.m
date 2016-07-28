//
//  ProductViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "ProductViewController.h"
#import "GoodTableViewCell.h"
#import "GoodModel.h"
#import "GoodDetailViewController.h"
@interface ProductViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *arr;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    [RequestManager requestWithUrlString:KGOODURL parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.arr = [GoodModel arr:dic];
        [self.table reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
    // Do any additional setup after loading the view.
}


-(void)creatTableView
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 60) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.rowHeight = 200;
    [self.view addSubview:self.table];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[GoodTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        
    }
    GoodModel *model = self.arr[indexPath.row];
    NSLog(@"%@",model.coverimg);
    [cell.btn addTarget:self action:@selector(buyAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell creatCell:model];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(void)buyAction:(UIButton *)btn
{
    GoodTableViewCell *cell = (GoodTableViewCell *)btn.superview.superview;
    NSIndexPath *path = [self.table indexPathForCell:cell];
    GoodModel *model = self.arr[path.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.buyurl]];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailViewController *good = [[GoodDetailViewController alloc]init];
    GoodModel *model = self.arr[indexPath.row];
    good.contentid = model.contentid;
    NSLog(@"%@",model.contentid);
    [self.navigationController pushViewController:good animated:YES];
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
