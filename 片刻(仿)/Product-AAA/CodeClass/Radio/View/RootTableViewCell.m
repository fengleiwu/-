//
//  RootTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell

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
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 120, 150)];
        self.texLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 20, 150, 40)];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 70, 150, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 110, 150, 30)];
        
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.texLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)creatCell:(RadioModel *)model
{
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.texLabel.text = model.title;
    self.nameLabel.text = [NSString stringWithFormat:@"by:%@",model.uname];
    self.titleLabel.text = model.desc;
}




@end
