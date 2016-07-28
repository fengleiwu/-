//
//  GoodDetailModel.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDetailModel : NSObject
@property(nonatomic , strong)NSString *addtime_f;//评论时间 也对应作者发布时间
@property(nonatomic , strong)NSString *content;//评论内容
@property(nonatomic , strong)NSString *icon;//评论头像 也对应楼主头像
@property(nonatomic , strong)NSString *uname;//评论人 也对应楼主名

@property(nonatomic , strong)NSString *comment;//消息数
@property(nonatomic , strong)NSString *like;//喜欢数
@property(nonatomic , strong)NSString *imgurl;//图片

@property(nonatomic , strong)NSString *title;//标题
@property(nonatomic , strong)NSString *songid;//应该是歌曲id


//上面commentlist对应评论区
//postsinfo addtime_f 发布时间
//counterList comment对应评论数  like对应喜欢数
@end
