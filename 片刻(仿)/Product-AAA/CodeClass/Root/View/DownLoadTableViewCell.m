//
//  DownLoadTableViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "DownLoadTableViewCell.h"

@implementation DownLoadTableViewCell

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
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 20)];
        self.titleL.font = [UIFont systemFontOfSize:15];
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 200, 20)];
        self.name.font = [UIFont systemFontOfSize:10];
        self.downLoadBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.downLoadBtn.frame = CGRectMake(self.frame.size.width - 100, 15, 80, 30);
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.downLoadBtn];
        
    }
    return self;
}


@end
