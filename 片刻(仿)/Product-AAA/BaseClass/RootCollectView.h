//
//  RootCollectView.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootCollectView : UIView

@property(nonatomic , assign)NSInteger inter;
@property (nonatomic, copy) void(^imageClick)(NSInteger index);



-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs;




@end
