//
//  MusicManager.h
//  UI06Object
//
//  Created by 吴峰磊 on 16/6/8.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "RadioDetailModel.h"

@interface MusicManager : NSObject

@property(nonatomic , assign)NSInteger indter;
@property(nonatomic , strong)AVPlayer  *player;
@property(nonatomic , assign)BOOL state;
@property(nonatomic , strong)NSMutableArray *array;
@property(nonatomic , copy)void (^play)(RadioDetailModel *model);
@property(nonatomic , copy)void (^MusicPlay)(NSArray *arr);

@property(nonatomic , assign)NSInteger inter;//判断什么播放


+ (MusicManager *)shareInstance;



#pragma mark --- 控制音量 ---
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat;

#pragma mark --- 播放/切换歌曲 ---
- (void)replaceItemWithUrlString:(NSString *)urlString;

#pragma mark --- 控制进度 ---
- (void)playerProgressWitProgressFloat:(CGFloat)progressFloat;

#pragma mark --- 播放/暂停 ---
- (void)playerPlayAndPause;

#pragma mark --- 上一首 ---
- (void)playerAbove;

#pragma mark --- 下一首 ---
- (void)playerNext;

#pragma mark --- 自动播放下一首 ---
- (void)playerAutoNext;




@end
