//
//  pinglunTableViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pinglunModel.h"

@interface pinglunTableViewCell : UITableViewCell
@property(nonatomic , strong)UIImageView *imagV;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UILabel *timeLabel;
@property(nonatomic , strong)UILabel *contentLabel;

-(void)creatCell:(pinglunModel *)model;


@end
