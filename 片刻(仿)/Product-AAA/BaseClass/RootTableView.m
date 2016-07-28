//
//  RootTableView.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootTableView.h"
#import "RootTableViewCell.h"
#import "ReadDetailModel.h"
#import "RootTwoTableViewCell.h"
@interface RootTableView()<UITableViewDataSource , UITableViewDelegate>

@property(nonatomic , strong)UITableView *table;
@property(nonatomic , strong)NSArray *imageURLs;


@end
@implementation RootTableView


-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs
{
    self = [super initWithFrame:frame];
    if (self) {
        if (imageURLs.count == 0) {
            return nil;
            
        }
        self.imageURLs = imageURLs;
        [self creatTableView];
    }
    return self;
}


-(void)creatTableView{
    //self.view.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight);
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:(UITableViewStylePlain)];
    self.table.separatorColor = [UIColor grayColor];
    self.table.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.delegate = self;
    self.table.dataSource = self;
    
    //self.table.rowHeight = self.height;
    [self addSubview:self.table];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageURLs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[RootTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        
        RadioModel *model = self.imageURLs[indexPath.row];
        [cell creatCell:model];
    }
    return cell;
    //
    //    else {
    //        RootTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
    //        if (!cell) {
    //            cell = [[RootTwoTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
    //
    //        }
    //        ReadDetailModel *model = self.imageURLs[indexPath.row];
    //        [cell creatCell1:model];
    //        return cell;
    //    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
