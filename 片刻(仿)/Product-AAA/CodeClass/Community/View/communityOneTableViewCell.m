//
//  communityOneTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "communityOneTableViewCell.h"

@implementation communityOneTableViewCell

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
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 250, 50)];
        
        self.titleLabel.font = [UIFont systemFontOfSize:20];
        self.titleLabel.numberOfLines = 0;
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 80, 80, 80)];
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 90, 240, 60)];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.numberOfLines = 0;
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 170, 80, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.pinglunBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.pinglunBtn.frame = CGRectMake(290, 170, 20, 20);
        [self.pinglunBtn setImage:[UIImage imageNamed:@"comment"] forState:(UIControlStateNormal)];
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(320, 170, 50, 20)];
        self.numberLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.pinglunBtn];
        [self.contentView addSubview:self.numberLabel];
    }
    return self;
}

//@property(nonatomic , strong)NSString *addtime_f;
//@property(nonatomic , strong)NSString *comment;
//@property(nonatomic , strong)NSString *title;
//@property(nonatomic , strong)NSString *icon;
//@property(nonatomic , strong)NSString *contentid;
//@property(nonatomic , strong)NSString *content;
//@property(nonatomic , strong)NSString *like;
//@property(nonatomic , strong)NSString *view;
//@property(nonatomic , strong)NSString *uname;
-(void)creatCell:(communityModel *)model
{
    self.titleLabel.text = model.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.addtime_f;
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.comment];
}

@end
