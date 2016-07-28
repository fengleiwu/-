//
//  GoodTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "GoodTableViewCell.h"

@implementation GoodTableViewCell

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
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 20, self.contentView.frame.size.width, self.contentView.frame.size.height + 100)];
        NSLog(@"%f",self.frame.size.height);
        //self.imageV.backgroundColor = [UIColor redColor];
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(30, self.contentView.frame.size.height + 130, (self.contentView.frame.size.width - 40) / 3 * 2 + 60, 20)];
        self.titleLable.font = [UIFont systemFontOfSize:15];
        self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btn.frame = CGRectMake((self.contentView.frame.size.width - 40)/6*5+40, self.contentView.frame.size.height + 130, (self.contentView.frame.size.width - 40)/6 + 40, 20);
        [self.btn setTitle:@"立即购买" forState:(UIControlStateNormal)];
        self.btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.btn];
    }
    return self;
}


-(void)creatCell:(GoodModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.titleLable.text = model.title;
}

@end
