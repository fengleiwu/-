//
//  RootTwoTableViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadDetailModel.h"

@interface RootTwoTableViewCell : UITableViewCell


@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *texLabel;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UILabel *titleLabel;
@property(nonatomic , assign)NSInteger inter;




-(void)creatCell1:(ReadDetailModel *)model;


@end
