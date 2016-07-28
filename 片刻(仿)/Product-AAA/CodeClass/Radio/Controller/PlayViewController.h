//
//  PlayViewController.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RightViewController.h"
#import "RadioDetailModel.h"

@interface PlayViewController : RightViewController
@property(nonatomic , assign)NSInteger inter;
@property(nonatomic , strong)NSMutableArray *arr;


@property(nonatomic , strong)NSMutableArray *array;



@property(nonatomic , strong)NSMutableArray *musicArr;
@property(nonatomic , assign)NSInteger musicInter;


@property(nonatomic , assign)BOOL isSelect;
@property(nonatomic , assign)BOOL Collect;


@end
