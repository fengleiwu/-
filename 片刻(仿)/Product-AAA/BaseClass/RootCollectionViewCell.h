//
//  RootCollectionViewCell.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
#import "RadioModel.h"
@interface RootCollectionViewCell : UICollectionViewCell
@property(nonatomic , strong)UIImageView *imageV;
@property(nonatomic , strong)UILabel *label1;
@property(nonatomic , strong)UILabel *label2;

-(void)creatItem:(ReadModel *)model;

-(void)creatItem1:(RadioModel *)model;
@end
