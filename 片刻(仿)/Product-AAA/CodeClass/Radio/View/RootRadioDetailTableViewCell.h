//
//  RootRadioDetailTableViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioDetailModel.h"

@interface RootRadioDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageVV;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UIButton *stateBtn;
-(void)creatCell:(RadioDetailModel *)model;

@end
