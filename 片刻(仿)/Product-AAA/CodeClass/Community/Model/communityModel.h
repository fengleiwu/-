//
//  communityModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface communityModel : NSObject
@property(nonatomic , strong)NSString *addtime_f;
@property(nonatomic , strong)NSString *comment;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *icon;
@property(nonatomic , strong)NSString *contentid;
@property(nonatomic , strong)NSString *content;
@property(nonatomic , strong)NSString *like;
@property(nonatomic , strong)NSString *view;
@property(nonatomic , strong)NSString *uname;

+(NSMutableArray *)arr:(NSDictionary *)dic;

@end
