//
//  pinglunTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "pinglunTableViewCell.h"

@implementation pinglunTableViewCell

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
        self.imagV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
        [self.imagV.layer setMasksToBounds:YES];
        [self.imagV.layer setCornerRadius:40];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 25, 150, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:17];
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 60, 150, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, kScreenWidth - 20, 60)];
        self.contentLabel.font = [UIFont systemFontOfSize:17];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.imagV];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.contentLabel];
        
    }
    return self;
}


-(void)creatCell:(pinglunModel *)model
{
    [self.imagV sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.uname;
    self.timeLabel.text = model.addtime_f;
    self.contentLabel.text = model.content;
}





@end
