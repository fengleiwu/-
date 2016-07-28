//
//  RootTableView.h
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableView : UIView
@property(nonatomic , assign)NSInteger inter;
@property(nonatomic , assign)CGFloat height;



-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs;
@end
