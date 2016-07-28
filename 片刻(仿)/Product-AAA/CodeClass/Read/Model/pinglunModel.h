//
//  pinglunModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pinglunModel : NSObject
@property(nonatomic , strong)NSString *addtime_f;
@property(nonatomic , strong)NSString *content;
@property(nonatomic , strong)NSString *contentid;
@property(nonatomic , strong)NSString *icon;
@property(nonatomic , strong)NSString *uname;
@property(nonatomic , assign)BOOL isdel;



+(NSMutableArray *)arr:(NSDictionary *)dic;
@end
