//
//  RadioModel.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RadioModel.h"

@implementation RadioModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)arr1:(NSDictionary *)dic1
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *dic2 = dic1[@"data"];
    NSArray *arr2 = dic2[@"carousel"];
    for (NSDictionary *dic3 in arr2) {
        RadioModel *model = [[RadioModel alloc]init];
        [model setValuesForKeysWithDictionary:dic3];
        [arr1 addObject:model];
    }
    return arr1;
}
+(NSMutableArray *)arr2:(NSDictionary *)dic2
{
    NSMutableArray *arr2 = [NSMutableArray array];
    NSDictionary *dic1 = dic2[@"data"];
    NSArray *arr3 = dic1[@"hotlist"];
    for (NSDictionary *dic3 in arr3) {
        RadioModel *model = [[RadioModel alloc]init];
        [model setValuesForKeysWithDictionary:dic3];
        [arr2 addObject:model];
    }
    return arr2;
}
+(NSMutableArray *)arr3:(NSDictionary *)dic3
{
    NSMutableArray *arr2 = [NSMutableArray array];
    NSDictionary *dic2 = dic3[@"data"];
    NSArray *arr4 = dic2[@"list"];
    for (NSDictionary *dic1 in arr4) {
        RadioModel *model = [[RadioModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSDictionary *dic4 = dic1[@"userinfo"];
        [model setValuesForKeysWithDictionary:dic4];
        [arr2 addObject:model];
        
    }
    return arr2;
}

@end
