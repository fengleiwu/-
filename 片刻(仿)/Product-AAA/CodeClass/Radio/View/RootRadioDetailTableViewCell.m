//
//  RootRadioDetailTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootRadioDetailTableViewCell.h"

@implementation RootRadioDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)creatCell:(RadioDetailModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.titleLabel.text = model.title;
    self.numberLabel.text = model.musicVisit;
    
}
@end
