//
//  RootTableViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioModel.h"

@interface RootTableViewCell : UITableViewCell


@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *texLabel;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UILabel *titleLabel;



-(void)creatCell:(RadioModel *)model;



@end
