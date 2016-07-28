//
//  communityOneTableViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "communityModel.h"

@interface communityOneTableViewCell : UITableViewCell
@property(nonatomic , strong)UILabel *titleLabel;
@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *contentLabel;
@property(nonatomic , strong)UILabel *timeLabel;
@property(nonatomic , strong)UIButton *pinglunBtn;
@property(nonatomic , strong)UILabel *numberLabel;

-(void)creatCell:(communityModel *)model;
@end
