//
//  RootCollectionViewCell.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootCollectionViewCell.h"

@implementation RootCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 30,60, 30)];
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(70, self.frame.size.height - 30, 60, 30)];
        self.label1.font = [UIFont systemFontOfSize:14];
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label1.textColor = [UIColor whiteColor];
        self.label2.textColor = [UIColor whiteColor];
        self.label2.textAlignment = NSTextAlignmentLeft;
        self.label1.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
    }
    return self;
}

-(void)creatItem:(ReadModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    
    self.label1.text = model.name;
    self.label2.text = model.enname;
}

-(void)creatItem1:(RadioModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
}


@end
