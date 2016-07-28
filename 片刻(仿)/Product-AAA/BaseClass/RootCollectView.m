//
//  RootCollectView.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RootCollectView.h"
#import "RootCollectionViewCell.h"
#import "ReadDetailViewController.h"
@interface RootCollectView()<UICollectionViewDelegate , UICollectionViewDataSource>
@property(nonatomic , strong)NSArray *imageURLs;
@property(nonatomic , strong)UICollectionView *collect;
@end
@implementation RootCollectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs
{
    self = [super initWithFrame:frame];
    if (self) {
        if (imageURLs.count == 0) {
            return nil;
            
        }
        self.imageURLs = imageURLs;
        [self creatCollectView];
    }
    return self;
}


-(void)creatCollectView
{
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc]init];
    lay.itemSize = CGSizeMake((kScreenWidth - 30) / 3 , (kScreenWidth - 30) / 3);
    lay.minimumInteritemSpacing = 5;
    lay.minimumLineSpacing = 5;
    lay.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:lay];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    self.collect.backgroundColor = [UIColor whiteColor];
    [self.collect registerClass:[RootCollectionViewCell class] forCellWithReuseIdentifier:@"ss"];
    [self addSubview:self.collect];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RootCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ss" forIndexPath:indexPath];
    ReadModel *model = self.imageURLs[indexPath.row];
    RadioModel *model1 = self.imageURLs[indexPath.row];
    if (self.inter == 2) {
        cell.label1.hidden = NO;
        cell.label2.hidden = NO;
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.duration = 1.0;
        animation.cumulative = YES;
        animation.repeatCount = 2;
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1.0, 0)];
        [cell.layer addAnimation:animation forKey:nil];
        [cell creatItem:model];
        
    }else if (self.inter == 1){
        cell.label1.hidden = YES;
        cell.label2.hidden = YES;
        [cell creatItem1:model1];
    }
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageURLs.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.inter == 1) {
        self.imageClick(indexPath.row);
        
    }else if (self.inter == 2) {
        
        ReadModel *model = self.imageURLs[indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"turn" object:model];
    }else{
        return;
    }
}





@end
