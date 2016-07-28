//
//  RootPlayTableViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioDetailModel.h"

@interface RootPlayTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIButton *btn;
@property (nonatomic , strong)RadioDetailModel *model;
@property (nonatomic , strong)UIView *progressView;


@end
