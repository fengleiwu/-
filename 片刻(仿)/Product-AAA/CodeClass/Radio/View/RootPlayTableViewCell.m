//
//  RootPlayTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootPlayTableViewCell.h"

@implementation RootPlayTableViewCell

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
        self.titLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 8, 250, 40)];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 63, 102, 21)];
        self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn.frame = CGRectMake(kScreenWidth - 50, 40, 20, 20);
        self.progressView = [[UIView alloc]initWithFrame:CGRectMake(-kScreenWidth,0,kScreenWidth,self.contentView.frame.size.height + 60)];
        self.progressView.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.progressView];
        [self.contentView addSubview:self.titLabel];
        [self.contentView addSubview:self.btn];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

@end
