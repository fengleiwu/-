//
//  RadioModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioModel : NSObject
@property(nonatomic , strong)NSString *coverimg;//collection
@property(nonatomic , strong)NSString *img;//轮播图的
@property(nonatomic , strong)NSString *url;

@property(nonatomic , strong)NSString *desc;//tableview右下方label
@property(nonatomic , strong)NSString *uname;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *radioid;


+(NSMutableArray *)arr1:(NSDictionary *)dic1;
+(NSMutableArray *)arr2:(NSDictionary *)dic2;
+(NSMutableArray *)arr3:(NSDictionary *)dic3;
@end
