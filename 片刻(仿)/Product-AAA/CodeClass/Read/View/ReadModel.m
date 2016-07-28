//
//  ReadModel.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)arr:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *dic1 = dic[@"data"];
    NSArray *arr2 = dic1[@"carousel"];
    for (NSDictionary *dic2 in arr2) {
        ReadModel *model = [[ReadModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr1 addObject:model];
    }
    return arr1;
    
}

+(NSMutableArray *)arr1:(NSDictionary *)dic1
{
    NSMutableArray *arr2 = [NSMutableArray array];
    NSDictionary *dic2 = dic1[@"data"];
    NSArray *arr3 = dic2[@"list"];
    for (NSDictionary *dic3 in arr3) {
        ReadModel *model = [[ReadModel alloc]init];
        [model setValuesForKeysWithDictionary:dic3];
        [arr2 addObject:model];
    }
    return arr2;
}


@end
