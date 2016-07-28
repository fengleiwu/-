//
//  GoodTableViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodModel.h"

@interface GoodTableViewCell : UITableViewCell

@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *titleLable;
@property(nonatomic , strong)UIButton *btn;

-(void)creatCell:(GoodModel *)model;

@end
