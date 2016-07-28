//
//  RootTwoTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootTwoTableViewCell.h"

@implementation RootTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, kScreenWidth, 60)];
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 70, 110, 90)];
        self.texLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 80, kScreenWidth - 110, 60)];
        self.texLabel.numberOfLines = 0;
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.texLabel];
    }
    
    
    return self;
}


-(void)creatCell1:(ReadDetailModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.titleLabel.text = model.title;
    self.texLabel.text = model.content;
}


@end
