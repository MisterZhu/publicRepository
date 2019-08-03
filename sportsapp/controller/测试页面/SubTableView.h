//
//  SubTableView.h
//  NestedTable
//
//  Created by LOLITA on 2017/9/19.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LolitaTableView.h"
#define getRandomNumberFromAtoB(A,B) (int)(A+(arc4random()%(B-A+1)))

@protocol SubTableViewDelegata <NSObject>

@optional

- (void)clickheadViewSection:(NSInteger)section withCell:(NSInteger)cell;

@end


@interface SubTableView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id <SubTableViewDelegata> SubTableDelegate;

@property (strong ,nonatomic) LolitaTableView *table;
//@property (nonatomic) UIButton *packageBtn;
@property (nonatomic) UIButton *detailBtn;
@property (nonatomic) UIButton *tripBtn;
@property (nonatomic) UIButton *costBtn;
@property (nonatomic) UIView *lineView;
@property (nonatomic) UIView *backView;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat oldY;
@property (nonatomic) BOOL isFirstLoad;

//是否上滑
@property (nonatomic) BOOL isUpScroll;
@property (nonatomic) NSInteger currentSection;

//@property (nonatomic) QFTTravelProductInfoModel *infoModel;

@property (nonatomic) BOOL isClick;


@end
