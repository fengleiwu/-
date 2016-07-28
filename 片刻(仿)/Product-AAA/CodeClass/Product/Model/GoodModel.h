//
//  GoodModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodModel : NSObject
@property(nonatomic , strong)NSString *buyurl;
@property(nonatomic , strong)NSString *contentid;
@property(nonatomic , strong)NSString *coverimg;
@property(nonatomic , strong)NSString *title;


+(NSMutableArray *)arr:(NSDictionary *)dic;
@end
