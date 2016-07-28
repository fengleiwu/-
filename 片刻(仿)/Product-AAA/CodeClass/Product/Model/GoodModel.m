//
//  GoodModel.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "GoodModel.h"

@implementation GoodModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)arr:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSArray *list = data[@"list"];
    for (NSDictionary *dic1 in list) {
        GoodModel *model = [[GoodModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr1 addObject:model];
    }
    return arr1;
}


@end
