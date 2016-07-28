//
//  RadioDetailModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicDownloadTable.h"
typedef NS_ENUM(NSInteger , downLoadType)
{
    downLoad,
    downLoading,
    downLoaded
};
@interface RadioDetailModel : NSObject<NSCoding>
@property(nonatomic , strong)NSString *uname;//标题
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *icon;//中间小头像
@property(nonatomic , strong)NSString *musicUrl;
@property(nonatomic , strong)NSString *musicVisit;
@property(nonatomic , strong)NSString *imgUrl;
@property(nonatomic , strong)NSString *coverimg;//标题对应图片和最上面图片
@property(nonatomic , strong)NSString *webview_url;
@property(nonatomic , strong)NSString *musicvisitnum;//中间访问人数
@property(nonatomic , strong)NSString *desc;//中间简介
@property(nonatomic , assign)BOOL isChose;
@property(nonatomic , assign)BOOL isDownLoad;

@property(nonatomic , assign)BOOL isPlay;

@property(nonatomic , assign)downLoadType downType;
+(NSMutableArray *)arr1:(NSDictionary *)dic;
+(NSMutableArray *)arr2:(NSDictionary *)dic;
+(NSMutableArray *)arr3:(NSDictionary *)dic;

@end
