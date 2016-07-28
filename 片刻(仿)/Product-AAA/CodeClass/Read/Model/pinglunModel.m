//
//  pinglunModel.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "pinglunModel.h"

@implementation pinglunModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)arr:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSDictionary *data = dic[@"data"];
    NSArray *list = data[@"list"];
    for (NSDictionary *dic1 in list) {
        pinglunModel *model = [[pinglunModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSDictionary *dic2 = dic1[@"userinfo"];
        [model setValuesForKeysWithDictionary:dic2];
        [arr1 addObject:model];
    }
    return arr1;
}

@end
